import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jfif';
    Color bgColor = data['isDayTime'] ? Colors.blueAccent[100] : Colors.black12;
    
    return Scaffold(  
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image : DecorationImage(
              image:  AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context,'/location');                    
                    print(result);
                    setState(() {
                      data = {
                        'time' : result['time'],
                        'location': result['location'],
                        'isDayTime' : result['isDayTime'],
                        'flag' : result['flag']
                      };
                    });
                  }, 
                  icon: Icon(
                    Icons.edit_location,
                    color : Colors.grey[300]
                    ),
                  label: Text(
                    'Edit Location', 
                    style:TextStyle(
                      color : Colors.grey[300]
                    )
                  )
                ),
                SizedBox(height :20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color : Colors.white
                      ),
                    ),                  
                  ],               
                ),
                SizedBox(height : 20),
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 60,
                        color : Colors.white
                      ),
                    )
              ],
            ),
          ),
        )
        ),
      
    );
  }
}