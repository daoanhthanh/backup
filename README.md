# backup

### temp

lazy val commonSettings = Seq(
   scalaVersion := "2.13.7",
   version := "0.1.0-SNAPSHOT",
   organization := "com.example",
   organizationName := "example",
   Test / parallelExecution := true,
   Test / fork := true,
   Compile / scalaSource := baseDirectory.value / "src" / "main" / "scala",
   Test / scalaSource := baseDirectory.value / "src" / "test" / "scala",
   Compile / resourceDirectory := baseDirectory.value / "src" / "main" / "resources",
   Test / resourceDirectory := baseDirectory.value / "src" / "test" / "resources"
)

lazy val root = (project in file("."))
  .settings(
     name := "sbt_practice" ,
     libraryDependencies ++= Seq(
        guice,
        "org.scalatestplus.play" %% "scalatestplus-play" % "5.1.0" % Test
     )
  )
  .settings(commonSettings)
  .aggregate(foo, bar)
  .dependsOn(foo, bar)
  .enablePlugins(PlayScala)
  .disablePlugins(PlayLayoutPlugin)


lazy val foo = (project in file("./app/Foo"))
  .aggregate(bar)
  .dependsOn(bar)
  .settings(commonSettings)
  .enablePlugins(PlayScala)
  .disablePlugins(PlayLayoutPlugin)


lazy val bar = (project in file("./app/Bar"))
  .settings(commonSettings)
  .enablePlugins(PlayScala)
  .disablePlugins(PlayLayoutPlugin) // use maven layout

