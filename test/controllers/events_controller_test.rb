require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { event_desc: @event.event_desc, event_end_date: @event.event_end_date, event_end_time: @event.event_end_time, event_name: @event.event_name, event_start_date: @event.event_start_date, event_start_time: @event.event_start_time, integer: @event.integer, map_id: @event.map_id, text: @event.text }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { event_desc: @event.event_desc, event_end_date: @event.event_end_date, event_end_time: @event.event_end_time, event_name: @event.event_name, event_start_date: @event.event_start_date, event_start_time: @event.event_start_time, integer: @event.integer, map_id: @event.map_id, text: @event.text }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
