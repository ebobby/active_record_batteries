require File.dirname(__FILE__) + '/spec_helper'

RSpec.describe ActiveRecordBatteries do
  before :all do
    # Have some authors
    Author.create((1..5).map { |i| { name: SecureRandom.urlsafe_base64(5) } })

    # And have eah author have some articles
    Author.all.each do |author|
      Article.create((1..10).map { |i|
                       {
                         title:  SecureRandom.urlsafe_base64(10),
                         body:   SecureRandom.urlsafe_base64(100),
                         author: author
                       }
                     })
    end
  end

  context "Deletable" do
    before :all do
      Article.create(title: "article_deletable", author: Author.first)
    end

    after :all do
      Article.including_deleted.find_by(title: "article_deletable").destroy
    end

    it "new instance should not deleted" do
       expect(Article.new.deleted?).to be false
    end

    it "new instance should be deleted" do
      expect(Article.new(deleted_at: Date.today).deleted?).to be true
    end

    it "should delete a new instance" do
      obj = Article.new
      obj.delete!

      expect(obj.deleted?).to be true
    end

    it "should not be deleted" do
      obj = Article.find_by(title: "article_deletable")

      expect(obj.deleted?).to be false
    end

    it "should delete" do
      obj = Article.find_by(title: "article_deletable")
      obj.delete!
      obj.save

      expect(obj.deleted?).to be true
    end

    it "should not find" do
      obj = Article.find_by(title: "article_deletable")
      expect(obj).to eq(nil)
    end

    it "should find" do
      obj = Article.including_deleted.find_by(title: "article_deletable")
      expect(obj).not_to eq(nil)
    end

    it "should stay deleted" do
      obj = Article.including_deleted.find_by(title: "article_deletable")
      expect(obj.deleted?).to be true
    end
  end

  context "Filterable" do
    before :all do
      Article.create(title: "article_filterable",  author: Author.first)
      Article.create(title: "article_filterable2", author: Author.first, slug: 'filtered_1')
    end

    after :all do
      Article.by_title("article_filterable").destroy_all
      Article.by_title("article_filterable2").destroy_all
    end

    it "should be hash" do
       expect(Article.filters).to be_an_instance_of(Hash)
    end

    it "should have filters" do
       expect(Article.filters.keys.size).to be > 0
    end

    it "should have filter" do
      expect(Article.filters[:by_title]).to be_truthy
    end

    it "should find" do
      results = Article.by_title("article_filterable")
      expect(results).not_to be_empty
    end

    it "should filter" do
      results = Article.filtered(by_title: "article_filterable2", by_slug: 'filtered_1')
      expect(results).not_to be_empty
    end
  end

  context "Paginable" do
    it "should set items per page" do
      expect(Author.items_per_page(2)).to eql(2)
    end

    it "should count pages" do
      expect(Article.pages).to eql((Article.count / 5.0).ceil)
    end

    it "should count pages with parameter passed" do
      expect(Article.pages(3)).to eql((Article.count / 3.0).ceil)
    end

    it "should paginate" do
      expect(Article.paginate(2).current_page).to eq(2)
    end

    it "should paginate with params" do
      expect(Article.paginate(3, 50).current_page).to eq(3)
    end

    it "should not lose items" do
      expect(Article.paginate(1).total_items).to eq(Article.count)
    end

    it "should count pages correctly after pagination" do
      expect(Article.paginate(2).total_pages).to eq(Article.pages)
    end

    it "should not be affected by includes" do
      expect(Author.includes(:articles).
              paginate(2).
              total_pages).to eq(Author.pages)
    end

    it "should not be affected by joins" do
      expect(Author.joins(:articles).
              paginate(2).
              total_pages).to eq(Author.pages)
    end
  end

  context "Sluggable" do
    it "should have a slug" do
      expect(Article.create(title: "Hello, world").slug).to eq("hello-world")
    end

    it "should qualify slugs" do
      expect { Article.create!(title: "Hello, world") }.to_not raise_error
      expect { Article.create!(title: "Hello, world") }.to_not raise_error
    end
  end
end
