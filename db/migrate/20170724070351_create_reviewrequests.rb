class CreateReviewrequests < ActiveRecord::Migration[5.1]
  def change
    create_table :reviewrequests do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :reviewer_id

      t.timestamps
    end
  end
end
