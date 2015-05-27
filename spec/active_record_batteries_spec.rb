require File.dirname(__FILE__) + '/spec_helper'

RSpec.describe ":deletable" do
  it "not deleted" do
    expect(Article.new.deleted?).to eq(false)
  end

  it "deleted" do
    expect(Article.new(deleted_at: Date.today).deleted?).to eq(true)
  end
end
