class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :rsvp, :cancel_rsvp]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    if @event.save
      flash[:notice] = "Your event has been created successfully!"
      redirect_to @event
    else
      flash.now[:notice] = "An error has occurred while creating your event"
      render "new"
    end
  end

  def edit 
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Your event has been updated successfully!"
      redirect_to @event
    else
      flash[:notice] = "Your event has not been updated successfully!"
      render "edit"
    end
  end

  def destroy 
    @event.destroy 
    redirect_to events_path
  end

  def rsvp
    if @event.attendees.include?(current_user)
      flash[:notice] = "You are already on the list"
      redirect_to @event 
    else
      @event.attendees << current_user
      redirect_to @event 
    end
  end

  def cancel_rsvp
    @event.attendees.delete(current_user)
    flash[:notice] = "You are no longer attending this event"
    redirect_to @event
  end

  def search
    @events = Event.where("location LIKE ?", "%" + params[:q] + "%")
  end

  private 

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:location, :date)
  end
end
