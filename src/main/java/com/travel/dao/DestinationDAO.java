package com.travel.dao;

import com.travel.model.Destination;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DestinationDAO {
    
    public List<Destination> getAllDestinations() {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Destination> destinations = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM destinations");
            
            while (rs.next()) {
                Destination destination = new Destination();
                destination.setId(rs.getInt("id"));
                destination.setName(rs.getString("name"));
                destination.setDescription(rs.getString("description"));
                destination.setCountry(rs.getString("country"));
                destination.setCity(rs.getString("city"));
                destination.setImageUrl(rs.getString("image_url"));
                destination.setRating(rs.getDouble("rating"));
                destination.setFeatured(rs.getBoolean("featured"));
                destinations.add(destination);
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
        
        return destinations;
    }
    
    public List<Destination> getFeaturedDestinations() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Destination> destinations = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM destinations WHERE featured = true";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Destination destination = new Destination();
                destination.setId(rs.getInt("id"));
                destination.setName(rs.getString("name"));
                destination.setDescription(rs.getString("description"));
                destination.setCountry(rs.getString("country"));
                destination.setCity(rs.getString("city"));
                destination.setImageUrl(rs.getString("image_url"));
                destination.setRating(rs.getDouble("rating"));
                destination.setFeatured(rs.getBoolean("featured"));
                destinations.add(destination);
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
        
        return destinations;
    }
    
    public Destination getDestinationById(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Destination destination = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM destinations WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                destination = new Destination();
                destination.setId(rs.getInt("id"));
                destination.setName(rs.getString("name"));
                destination.setDescription(rs.getString("description"));
                destination.setCountry(rs.getString("country"));
                destination.setCity(rs.getString("city"));
                destination.setImageUrl(rs.getString("image_url"));
                destination.setRating(rs.getDouble("rating"));
                destination.setFeatured(rs.getBoolean("featured"));
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
        
        return destination;
    }
    
    public boolean addDestination(Destination destination) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO destinations (name, description, country, city, image_url, rating, featured) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, destination.getName());
            stmt.setString(2, destination.getDescription());
            stmt.setString(3, destination.getCountry());
            stmt.setString(4, destination.getCity());
            stmt.setString(5, destination.getImageUrl());
            stmt.setDouble(6, destination.getRating());
            stmt.setBoolean(7, destination.isFeatured());
            
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
    
    public boolean updateDestination(Destination destination) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE destinations SET name = ?, description = ?, country = ?, city = ?, image_url = ?, rating = ?, featured = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, destination.getName());
            stmt.setString(2, destination.getDescription());
            stmt.setString(3, destination.getCountry());
            stmt.setString(4, destination.getCity());
            stmt.setString(5, destination.getImageUrl());
            stmt.setDouble(6, destination.getRating());
            stmt.setBoolean(7, destination.isFeatured());
            stmt.setInt(8, destination.getId());
            
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
    
    public boolean deleteDestination(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM destinations WHERE id = ?";
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
    
    public List<Destination> searchDestinations(String keyword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Destination> destinations = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM destinations WHERE name LIKE ? OR description LIKE ? OR country LIKE ? OR city LIKE ?";
            stmt = conn.prepareStatement(sql);
            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            stmt.setString(4, searchTerm);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Destination destination = new Destination();
                destination.setId(rs.getInt("id"));
                destination.setName(rs.getString("name"));
                destination.setDescription(rs.getString("description"));
                destination.setCountry(rs.getString("country"));
                destination.setCity(rs.getString("city"));
                destination.setImageUrl(rs.getString("image_url"));
                destination.setRating(rs.getDouble("rating"));
                destination.setFeatured(rs.getBoolean("featured"));
                destinations.add(destination);
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
        
        return destinations;
    }
}
