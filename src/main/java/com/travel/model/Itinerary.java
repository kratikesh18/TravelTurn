package com.travel.model;

public class Itinerary {
    private int id;
    private int bookingId;
    private String day;
    private String activity;
    private String description;
    private String timeSlot;

    public Itinerary() {
    }

    public Itinerary(int id, int bookingId, String day, String activity, String description, String timeSlot) {
        this.id = id;
        this.bookingId = bookingId;
        this.day = day;
        this.activity = activity;
        this.description = description;
        this.timeSlot = timeSlot;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }
}
