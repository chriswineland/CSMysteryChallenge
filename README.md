CSMysteryChallenge
==================

Hello and Thanks again for your time!
I have made an app that fetched couchsurfing Tumblr posts and displays them in a tableview.
once the data has loaded you can tap a cell and cycle through all the images associated with a single post
I used the refresh object to allow the user to refetch data (pull down on the table view once already at the top)

--Concerns--
my biggest concern is the shear amount of data being displayed in a single cell. If I had more Time I would have refactored the cell to be a brief description of the post and have the tap action open up into a detail page, however having already implanted tap to cycle through images would have been a complete rewrite and I did not feel like that was part of this excursive.

--Some cool things in the app--
ImageStore is a cool little cache, it adds a layer of obfuscation to returning images. it fakes as if it has the image with the place holder even if it needs to fetch the image. This construct also cuts down on network calls which saves the users battery (Thumbs up)

I created my first NIB! Im sure there is much room for improvement there however it didn’t kill me :)

After doing a couple of Unit Tests in XCT I would highly recommend using KIWI, I just scraped the surface with testing in XCT but after reading tutorials and the apple docs it just does not read out as KIWI does.

I tried to comment a little more then I normally would but if you have any questions feel free to send me an IM or text, I would be happy to chat about it :)
