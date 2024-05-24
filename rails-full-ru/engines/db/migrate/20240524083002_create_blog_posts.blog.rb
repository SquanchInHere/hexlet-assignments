# This migration comes from blog (originally 20240524082645)
class CreateBlogPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
