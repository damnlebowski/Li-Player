// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print, prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'package:fi_player/screens/screen_arranged_video_folder/screen_arranged_video_folder.dart';
import 'package:fi_player/screens/screen_local_folder/screen_local_folder.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import '../functions/all_functions.dart';
import '../screens/screen_inner_playlist/screen_inner_playlist.dart';
import 'drawer.dart';

//all videos section list view widget
class GridViewWidgetForAllVideos extends StatelessWidget {
  GridViewWidgetForAllVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return allVideosNotify.value.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'There Is No Videos',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: allVideosNotify.value.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                videoPath: allVideosNotify.value[index],
                                fromList: allVideosNotify.value,
                                curentIndex: index,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 130,
                          child: ColoredBox(color: Colors.blue),
                        ),
                        ListTile(
                          title: Text(
                            getVideoName(allVideosNotify.value[index]),
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: mainBGColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Add to liked videos',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  if (!likedVideoNotify.value
                                      .contains(allVideosNotify.value[index])) {
                                    likedVideoNotify.value
                                        .add(allVideosNotify.value[index]);
                                    log('Successfully added to liked videos');
                                    snackBarMessage(context,
                                        'Successfully Added To Liked Videos');
                                  } else {
                                    log('already contains');
                                    snackBarMessage(
                                        context, 'Already Contains');
                                  }
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Add to Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  showDialougeOfPlaylist(context,
                                      videoIndex: index,
                                      listFrom: allVideosNotify.value);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}

//inner videos section list view widget
class GridViewWidgetForInnerVideos extends StatelessWidget {
  GridViewWidgetForInnerVideos({super.key, required this.innerFolderData});

  List<String> innerFolderData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: innerFolderData.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return InkWell(
              //liked and playlist
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoPlayingPage(
                          videoPath: innerFolderData[index],
                          fromList: innerFolderData,
                          curentIndex: index,
                        )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 130,
                    child: ColoredBox(color: Colors.blue),
                  ),
                  ListTile(
                    title: Text(
                      getVideoName(innerFolderData[index]),
                      style: TextStyle(color: allTextColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                      color: mainBGColor,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Add to liked videos',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            if (!likedVideoNotify.value
                                .contains(innerFolderData[index])) {
                              likedVideoNotify.value
                                  .add(innerFolderData[index]);
                              log('Successfully added to liked videos');
                              snackBarMessage(context,
                                  'Successfully Added To Liked Videos');
                            } else {
                              log('already contains');
                              snackBarMessage(context, 'Already Contains');
                            }
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Add to Playlist',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            showDialougeOfPlaylist(context,
                                videoIndex: index, listFrom: innerFolderData);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}

//all folders section list view widget
class GridViewWidgetForFolders extends StatelessWidget {
  GridViewWidgetForFolders({super.key});

  @override
  Widget build(BuildContext context) {
    return allFolders.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'No Folders',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: allFolders.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            FolderInnerPage(folderAddress: allFolders[index]),
                      ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_rounded,
                          size: 70,
                          color: Colors.purple,
                        ),
                        Text(
                          getVideoName(allFolders[index]),
                          style: TextStyle(color: allTextColor),
                          // maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ));
              },
            ),
          );
  }
}

//liked videos section list view widget
class GridViewWidgetForLikedVideos extends StatelessWidget {
  GridViewWidgetForLikedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return likedVideoNotify.value.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'No Liked Videos Yet',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: likedVideoNotify.value.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                videoPath: likedVideoNotify.value[index],
                                fromList: likedVideoNotify.value,
                                curentIndex: index,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 130,
                          child: ColoredBox(color: Colors.blue),
                        ),
                        ListTile(
                          title: Text(
                            getVideoName(likedVideoNotify.value[index]),
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: mainBGColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Remove from liked videos',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  likedVideoNotify.value
                                      .remove(likedVideoNotify.value[index]);
                                  // likedVideoNotify.notifyListeners();
                                  isListView.notifyListeners();
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Add to Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  showDialougeOfPlaylist(context,
                                      videoIndex: index,
                                      listFrom: likedVideoNotify.value);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}

//playlist section list view widget
class GridViewWidgetForPlaylist extends StatelessWidget {
  GridViewWidgetForPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return playlist.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Playlist Is Empty',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: playlist.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlaylistInsidePage(
                                playlistIndex: index,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_play,
                          color: Colors.purple,
                          size: 60,
                        ),
                        ListTile(
                          title: Text(
                            playlistKey[index],
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: mainBGColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Rename Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  // if (!likedVideoNotify.value
                                  //     .contains(allVideosNotify.value[index])) {
                                  //   likedVideoNotify.value
                                  //       .add(allVideosNotify.value[index]);
                                  //   log('Successfully added to liked videos');
                                  // } else {
                                  //   log('already contains');
                                  // }
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Delete Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  log('Removed "${playlistKey[index]}"');
                                  snackBarMessage(context,
                                      'Playlist "${playlistKey[index]}" Deleted');
                                  playlist.remove(playlistKey[index]);
                                  playlistKey.removeAt(index);
                                  isListView.notifyListeners();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}

//inner playlist section list view widget
class GridViewWidgetForInnerPlaylist extends StatelessWidget {
  GridViewWidgetForInnerPlaylist({super.key, required this.playlistName});
  String playlistName;
  @override
  Widget build(BuildContext context) {
    return playlist[playlistName]!.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'No Videos In This Playlist',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: playlist[playlistName]?.length ?? 0,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                videoPath: playlist[playlistName]![index],
                                fromList: playlist[playlistName]!,
                                curentIndex: index,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 130,
                          child: ColoredBox(color: Colors.blue),
                        ),
                        ListTile(
                          title: Text(
                            getVideoName(playlist[playlistName]![index]),
                            // textAlign: TextAlign.center,
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: mainBGColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                  'Remove From Playlist',
                                  style: TextStyle(color: allTextColor),
                                ),
                                onTap: () {
                                  log('Song Removed From "$playlistName"');
                                  snackBarMessage(context,
                                      'Song Removed From "$playlistName"');
                                  playlist[playlistName]!.removeAt(index);
                                  isListView.notifyListeners();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}
