import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController promptController;
  String responseTxt = '';
  late ResponseModel _responseModel;

  @override
  void initState(){
    promptController = TextEditingController();
    super.initState();
  }
  
  @override
  void dispose(){
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          'Flutter and ChatGPT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PromptBldr(responseTxt: responseTxt),
          TextFormFieldBldr(promptController: promptController, btnFun: completionFun),
        ],
      ),
    );
  }

  completionFun() async { 
    setState( () => responseTxt = 'Loading...');

    final response = await http.post( 
      Uri.parse(''),
      headers: {
        'Conten-Type': 'application/json',
        'Authorization': 'Bearer '
      },
      body: jsonEncode({}).
    );
    
    setState(() {
      _responseModel = ResponseModel.fromJson(response.body);
    })
  }
}

class PromptBldr extends StatelessWidget {
  const PromptBldr({
    super.key,
    required this.responseTxt,
  });

  final String responseTxt;

  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 1.35,
      color: const Color(0xff434654),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Text(
            responseTxt,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 25, color: Colors.white)
          )
        ,)
      ),
    )
  }
}

class TextFormFieldBldr extends StatelessWidget{
  const TextFormFieldBldr({super.key, required this.promptController, required this.btnFun});

  final TextEditingController promptController;
  final Function btnFun;

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left:10, right: 10, bottom:50),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorColor: Colors.white,
                controller: promptController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize:20),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff444653),
                    ),
                    borderRadius: BorderRadius.circular(5.5), 
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff444653),
                    )
                  ),
                  filled: true,
                  fillColor: const Color(0xff444653),
                  hintText: 'Ask me anything!',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              color: const Color(0xff19bc99),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () => btnFun(),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )
                )
              )
            )
          ],
        )
      )
    );
  }
}