class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    config_opentok

    @tok_token = @opentok.generate_token :session_id =>
      @room.sessionId

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # POST /rooms
  # POST /rooms.json
  def create
    config_opentok
    session = @opentok.create_session request.remote_addr
    params[:room][:sessionId] = session.session_id
    
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end

  private
  def config_opentok
    @API_KEY = OpentokDemo::Application.config.api_key
    @API_SECRET = OpentokDemo::Application.config.secret_token
    
    if @opentok.nil?
      @opentok = OpenTok::OpenTokSDK.new @API_KEY, @API_SECRET
    end
  end
end
