package com.travel.dao;

import com.travel.model.Itinerary;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItineraryDAO {
    
    public boolean addItinerary(Itinerary itinerary) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO itineraries (booking_id, day, activity, description, time_slot) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itinerary.getBookingId());
            stmt.setString(2, itinerary.getDay());
            stmt.setString(3, itinerary.getActivity());
            stmt.setString(4, itinerary.getDescription());
            stmt.setString(5, itinerary.getTimeSlot());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    public List<Itinerary> getItinerariesByBookingId(int bookingId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Itinerary> itineraries = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM itineraries WHERE booking_id = ? ORDER BY day, time_slot";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Itinerary itinerary = new Itinerary();
                itinerary.setId(rs.getInt("id"));
                itinerary.setBookingId(rs.getInt("booking_id"));
                itinerary.setDay(rs.getString("day"));
                itinerary.setActivity(rs.getString("activity"));
                itinerary.setDescription(rs.getString("description"));
                itinerary.setTimeSlot(rs.getString("time_slot"));
                itineraries.add(itinerary);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return itineraries;
    }
    
    public boolean updateItinerary(Itinerary itinerary) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE itineraries SET day = ?, activity = ?, description = ?, time_slot = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, itinerary.getDay());
            stmt.setString(2, itinerary.getActivity());
            stmt.setString(3, itinerary.getDescription());
            stmt.setString(4, itinerary.getTimeSlot());
            stmt.setInt(5, itinerary.getId());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    public boolean deleteItinerary(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM itineraries WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
}
