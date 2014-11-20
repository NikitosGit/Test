class ItemsController < ApplicationController
	
	before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote]
	before_filter :check_if_admin,  only: [:edit, :update, :new, :create, :destroy]

	def index	
		@items = Item.all
		render "items/index" # рендер можно не указывать. 
							 #По умолчанию рендерится шаблон, совпадающий с названием метода т. е. index.html.erb
		
		#render text: @items.map {|i| "#{i.id} #{i.name}: #{i.price}"}.join("<br/>")
	end


	def expensive
		@items = Item.where("price>499")
		render "index"
	end


	#url /items/1 GET
	def show
		#unless @item = Item.where(id: params[:id]).first #@item = Item.find(params[:id]) - сам придумал :) вроде работает
		unless @item
			render text: "Page not found", status: 404
		end
	end


	#url /items/new GET
	def new
		@item = Item.new
	end


	#url /items/1/edit GET
	def edit
	end


	#url /items POST
	def create
		#@item = Item.create(name: params[:name], description: params[:description], price: 
		#	params[:price], real: params[:real], weight: params[:weight])
		
		@item = Item.create(item_params)
		if @item.errors.empty?
			redirect_to item_path(@item)	#items/:id
		else
			render "new"
		end	
	#	p params
	#	render text: "#{@item.id}: #{@item.name} #{@item.price} (#{!@item.new_record?})"
	#	render text: params.inspect
	end


	#url /items/1 PUT
	def update
		@item.update_attributes(item_params)#item_params - хэш параметров из браузера
		if @item.errors.empty?
			redirect_to item_path(@item)	#items/:id
		else
			render "edit"
		end	
	end


	#url /items/1 DELETE
	def destroy
		@item.destroy
		redirect_to action: "index"
	end


	def upvote
		@item.increment!(:votes_count)
		redirect_to action: :index
	end


	private 
		
	def item_params
		params.require(:item).permit(:name, :description, :price, :weight, :real)
	end


	def find_item
		@item = Item.where(id: params[:id]).first
		render_404 unless @item
	end


	def check_if_admin
#		render text: "Access denied", status: 403 unless params[:admin]
		render_403 unless params[:admin]
	end
end
