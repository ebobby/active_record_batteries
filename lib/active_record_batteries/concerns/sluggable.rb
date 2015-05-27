module ActiveRecordBatteries
  module Concerns
    module Sluggable
      extend ActiveSupport::Concern

      included do
        # Backwards compatibility
        slug_base_column :name

        # Be sure to create a valid slug before validating and saving.
        before_validation :set_slug, on: [:create, :update]
        after_validation :delete_slug_errors

        # Scope to query by slug
        scope :by_slug, ->(slug) { where(slug: slug) }

        # Slug must be present
        validates :slug, presence: true, uniqueness:true, length: { maximum: 256 }
      end

      module ClassMethods
        def slug_base_column(column_name)
          @slug_base_column_name = column_name.to_sym
        end

        # Find by slug
        def find_by_slug(slug)
          by_slug(slug).take
        end
      end

      def to_param
        slug
      end

      private

      def slug_base_column_value
        send(self.class.instance_variable_get(:@slug_base_column_name))
      end

      def set_slug
        self.slug = qualify_slug(slug_base_column_value.parameterize) if
          slug_base_column_value.present? && slug.blank?
      end

      def delete_slug_errors
        errors.delete(:slug)
      end

      def qualify_slug(base_slug)
        tentative_slug = base_slug
        while duplicate_slug?(tentative_slug)
          tentative_slug = generate_slug_name(base_slug)
        end
        tentative_slug
      end

      def duplicate_slug?(slug)
        self.class
          .where.not(id: id)
          .exists?(slug: slug)
      end

      def generate_slug_name(slug)
        "#{slug}-#{SecureRandom.urlsafe_base64(4)}"
      end
    end
  end
end
