# Smogler #

Location based air quality information, on your iPhone and your Apple Watch. 

## How do I get started? ##

The first step is to [acquire your own token for the WAQI API access](https://aqicn.org/data-platform/token/#/).

Look up the `token` constant in `APIService.swift` and replace the dummy string with your token.

The project has no external dependencies at the moment, so you should be fine building/running it. :+1:

### Where's the air quality data coming from? ###

From the [public API](https://aqicn.org/api/) of the [World Air Quality Index Project](https://waqi.info/) originating EPA.

## How does the app look like? ##

1. iPhone app

![Smogler iPhone](https://user-images.githubusercontent.com/1460573/48306572-9d2ba500-e4ef-11e8-84c7-183063504339.png)

2. Watch app

![Smogler Watch](https://user-images.githubusercontent.com/1460573/48306532-2098c680-e4ef-11e8-81ed-f2da473301bd.png)

3. Watch complication

![Smogler Watch complication](https://user-images.githubusercontent.com/1460573/48306530-2098c680-e4ef-11e8-9547-b8c14f239daf.png)

## What's next?

There's always room for improvement, Smogler is no exception. 

[1.](https://github.com/vasarhelyia/Smogler/issues/4) Make sure things fetch the API only when necessary and try to move all the load possible to the iOS app. That was the initial goal, but there are so many scenarios (iOS app active, background, etc., Watch app active, background, ...), I might have gotten a bit lost sorting these out.

[2.](https://github.com/vasarhelyia/Smogler/issues/5) Writing tests for the Watch extension is not trivial, but it would be nice to see how it's possible.

[3.](https://github.com/vasarhelyia/Smogler/issues/1) Push notifications - to be alerted in case the air quality dropped, for example.

[4.](https://github.com/vasarhelyia/Smogler/issues/6) More supported complication families?
