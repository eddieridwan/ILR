class ResourcesController < ApplicationController
  before_filter :authorize, :except => [:list, :new, :create, :show]
  layout "nosidebar"

  def list
    @title = "Indonesian Language Resources"
    @resources = Resource.reviewed  
    render :layout => 'resource'
  end
  
  # GET /resources
  # GET /resources.xml
  def index
    @title = "Indonesian Language Resources"
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])
    @resource.status = User.find_by_id(session[:user_id]) ? "reviewed" : "draft"

    respond_to do |format|
      if @resource.save
        if User.find_by_id(session[:user_id])
          flash[:notice] = 'Resource was successfully created.'
        else
          notify_resource_added(@resource, request)
          flash[:notice] = 'Thank you for adding the resource. It will appear in the resource list after we have reviewed it.'
        end
        format.html { redirect_to(@resource) }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to(@resource) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end

protected
#  def authorize
#    unless User.find_by_id(session[:user_id])
#      session[:original_uri] = request.request_uri
#      flash[:notice] = "Please log in"
#      redirect_to :controller => 'admin' , :action => 'login'
#    end
#  end

  def notify_resource_added(resource, request)
    email = OrderMailer.create_resource_added(resource, request)
    Thread.new(email) do |e|
      OrderMailer.deliver(email)
    end
  end
end


