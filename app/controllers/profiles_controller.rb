class ProfilesController < ApplicationController

	before_action :authenticate_user!



	def index

	end

	def myarticle

		@myarticles = current_user.articles

	end

	def show 

	end

	def privatearticle
		@mydraft = current_user.articles.where(:visibility => false)

	end

	def myreview

		@myreviews = current_user.reviews

	end

	def reviewrequest

	@reviews = Review.where(:visibility => :false)

	@a =[]

	@reviews.each do |f|
		@a.push(f.article_id)	# Article ID of all review with visibility false
	end

	@b =[]
	
	@a.each do |n|
		@b.push(Article.find(n).user_id) # User ID of Articles with visibility false
	end
	
	@c = []
	@b.each do |p|
	
		if current_user.id == p
			@c.push(p) #Current User's Article ID receiving review request with visibility false
		end
	
	end


	@articlereq = Article.where(:user_id => @c) #find the articles of currently logged in user id 
	@temp = []
	@articlereq.each do |i|
		@temp.push(i.id)
	end

   	@reviewreq = Review.where(:article_id => @temp) #owner arcticle requests

	end

	def privaterequest

		@review_requests = Reviewrequest.where(:reviewer_id => current_user.email)

		@art_id = []

		@review_requests.each do |f|
			@art_id.push(f.article_id)
		end
		
		@article = Article.where(:id => @art_id)

	end

	def update_visibility_of_review_true
  		@review = Review.find(params[:id])
  		@review.update_attribute(:visibility, true)
	end

	def update_visibility_of_article_true
      @article = Article.find(params[:id])
      @article.update_attribute(:visibility, true)
  	end
 

	def accountinfo

		
    if user_signed_in?

      @current_user_count = Article.where(:user_id => current_user.id)
    
      @current_user_reviews = Review.where(:user_id => current_user.id)

      @cur_private_review = current_user.reviews.where(:visibility => false)

      @cur_private_article = current_user.articles.where(:visibility => false)

      @cur_public_article = Article.where(:user_id => current_user.id, :visibility => true)

      @a = []

      @cur_public_article.each do |f|
        @a.push(f.id)
      end

      @abc = Review.where(:article_id => @a)


      @review_requests = Reviewrequest.where(:reviewer_id => current_user.email)

      @art_id = []

      @review_requests.each do |f|
        @art_id.push(f.article_id)
      end


    
    end

	end

end
