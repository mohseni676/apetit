import 'package:http/http.dart' as http;
import 'package:apetit/classes/globals.dart' as globals;

void main() async{


    var response=await http.post('${globals.ServerAddress}/api/v1/coach/category',
        body: {
          "id" : "0"
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${globals.token}'

        }
    );



  }



