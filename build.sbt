val spinalVersion = "1.8.1"

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.github.spinalhdl",
      scalaVersion := "2.11.12",
      version      := "0.1.1-SNAPSHOT"
    )),
    name := "VexRiscvOnWishbone",

    libraryDependencies ++= Seq(
      compilerPlugin("com.github.spinalhdl" % "spinalhdl-idsl-plugin_2.11" % spinalVersion)
    )
  ).dependsOn(vexRiscv)

lazy val vexRiscv = RootProject(file("ext/VexRiscv"))
fork := true
