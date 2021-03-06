require 'spec_helper'

describe "simple_bookmarks" do
  let(:filename) { 'test.rb' }
  let(:contents) { ['line 1', 'line 2', 'line 3'] }
  let(:bookmark_name) { 'simple_bookmarks_spec' }

  before do
    set_file_contents contents.join("\n")
  end

  after do
    delete_bookmark
  end

  describe "Bookmark" do
    it "creates a bookmark at the current line" do
      vim.command '2'
      create_bookmark

      vim.edit!('tmp.rb')
      open_bookmark

      vim.echo('getline(".")').should eq contents[1]
      vim.echo('expand("%")').should eq filename
    end
  end

  describe "DelBookmark" do
    it "deletes a previously created bookmark" do
      vim.command '2'
      create_bookmark

      vim.command '1'
      delete_bookmark

      open_bookmark
      vim.echo('getline(".")').should eq contents[0]
    end
  end
end
