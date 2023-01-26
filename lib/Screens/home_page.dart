import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imagegenerator/Providers/image_provider.dart';
import 'package:imagegenerator/Screens/fullscreen_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void getImage(String value){
    Provider.of<GeneratedImageProvider>(context,listen: false).getImageLink(value);
    FocusScope.of(context).unfocus();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    bool isLoading = Provider.of<GeneratedImageProvider>(context,listen: true).isLoading;
    bool initialLoad = Provider.of<GeneratedImageProvider>(context,listen: false).initialLoad;
    String link = Provider.of<GeneratedImageProvider>(context,listen: false).link;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dall-E"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: SizedBox(
                child: Center(
                  child: initialLoad ? const Text("Welcome to Dall-E",style: TextStyle(fontSize: 25),) :
                  isLoading ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      :
                  GestureDetector(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenView(link: link),));
                    },
                    child: Hero(
                      tag: link,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: link,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _controller,
              onSubmitted: (value){
                getImage(value);
              },
              decoration: InputDecoration(
                hintText: "Enter something",
                suffixIcon: IconButton(
                  onPressed: (){
                    getImage(_controller.value.text.trim());
                  },
                  icon: const Icon(Icons.send),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
