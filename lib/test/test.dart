
    backgroundColor: Colors.grey[850], // Consistent background color
    bottomNavigationBar: Padding(
      padding: EdgeInsets.all(10.0),
      child: Center( // Center the button
        child: Container( // Control the width of the button
          width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
          child: ElevatedButton(
            onPressed: () => _showProPurchaseDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4AFF2F),
              foregroundColor: Colors.pink[400],
              textStyle: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            child: Text(
              'Buy',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    ),

