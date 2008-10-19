class WikiPagesController < ApplicationController
  # GET /wiki_pages
  # GET /wiki_pages.xml
  def index
    @wiki_pages = WikiPage.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wiki_pages }
    end
  end

  # GET /wiki_pages/1
  # GET /wiki_pages/1.xml
  def show
    @wiki_page = WikiPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wiki_page }
    end
  end

  # GET /wiki_pages/new
  # GET /wiki_pages/new.xml
  def new
    @wiki_page = WikiPage.new
    @wiki_page.slug = params[:wiki_page][:slug]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wiki_page }
    end
  end

  # GET /wiki_pages/1/edit
  def edit
    @wiki_page = WikiPage.find(params[:id])
  end

  # POST /wiki_pages
  # POST /wiki_pages.xml
  def create
    @wiki_page = WikiPage.new(params[:wiki_page])

    respond_to do |format|
      if @wiki_page.save
        flash[:notice] = 'WikiPage was successfully created.'
        format.html { redirect_to(@wiki_page) }
        format.xml  { render :xml => @wiki_page, :status => :created, :location => @wiki_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wiki_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wiki_pages/1
  # PUT /wiki_pages/1.xml
  def update
    @wiki_page = WikiPage.find(params[:id])

    respond_to do |format|
      if @wiki_page.update_attributes(params[:wiki_page])
        flash[:notice] = 'WikiPage was successfully updated.'
        format.html { redirect_to(@wiki_page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wiki_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wiki_pages/1
  # DELETE /wiki_pages/1.xml
  def destroy
    @wiki_page = WikiPage.find(params[:id])
    @wiki_page.destroy

    respond_to do |format|
      format.html { redirect_to(wiki_pages_url) }
      format.xml  { head :ok }
    end
  end
end
