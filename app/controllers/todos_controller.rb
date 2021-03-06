class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /completed
  # GET /completed.json
  def completed
    @todos = Todo.completed

    respond_to do |format|
      format.html { render :index } # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /active
  # GET /active.json
  def active
    @todos = Todo.active

    respond_to do |format|
      format.html { render :index }# index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.create_and_initialise(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_complete
    # change and save
    @todo = Todo.find(params[:id])
    @todo.toggle_completed!

    respond_to do |format|
      format.html { redirect_to todos_path }    #I'm guessing this should just return the view of all todos? Is this how you do that?
      format.json { head :no_content }
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to todos_path, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end
end
