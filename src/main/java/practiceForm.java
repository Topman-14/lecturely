
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */

/**
 *
 * @author TOPE
 */
public class practiceForm extends javax.swing.JFrame {

    /**
     * Creates new form practiceForm
     */
    public practiceForm() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 665, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 380, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        
        String url = "jdbc:mysql://lecturely-lecturely.a.aivencloud.com:26890/defaultdb";
        String username = "avnadmin";
        String password = "AVNS_0dlNs7bXHBdk264ESfO";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to MySQL database");
            
            createAndAddUserTable(connection);

            // Perform database operations using the connection object

            connection.close();
            System.out.println("Connection closed");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection error");
            e.printStackTrace();
        }

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new practiceForm().setVisible(true);
            }
        });
    }
    
public static void createAndAddUserTable(Connection connection) {
    String createTableQuery = "CREATE TABLE IF NOT EXISTS users ( " +
        "id INT PRIMARY KEY AUTO_INCREMENT, " +
        "name VARCHAR(255) NOT NULL, " +
        "email VARCHAR(255) NOT NULL UNIQUE, " +
        "password VARCHAR(255) NOT NULL)";

    String insertUserQuery = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

    try {
        Statement statement = connection.createStatement();
        statement.executeUpdate(createTableQuery);

        PreparedStatement preparedStatement = connection.prepareStatement(insertUserQuery);
        preparedStatement.setString(1, "John Doe");
        preparedStatement.setString(2, "johndoe@example.com");
        preparedStatement.setString(3, "password123");
        preparedStatement.executeUpdate();

        System.out.println("User table created and user added successfully.");
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
