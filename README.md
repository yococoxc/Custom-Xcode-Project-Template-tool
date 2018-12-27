# Custom-Xcode-Project-Template-tool
这是一个辅助自定义Xcode项目模板的工具。This is a tool that aids in customizing Xcode project templates.

【中】
我在写Xcode项目模板的时候发现，如果模板有很多个文件，那就得往TemplateInfo.plist 文件写很多东西，而且有一定逻辑关系，不是那么容易手动写。
身为程序员，天生就是应该创造工具来简化自己的工作，让一切都傻瓜化。当然，前期的研究是少不了的。
我千辛万苦终于理解了怎么自定义Xcode 项目模板了。根据逻辑写下了这个工具。
为什么是iOS项目呢......因为我最懂的就是iOS，所以顺手就用了iOS来实现，改天试试用其他语言来实现吧。
因为是iOS项目的缘故。你需要把你的文件夹了拉到模拟器的document 路径下，然后执行这个项目，就会生成到 TemplateInfo.plist 文件，然后覆盖你的Xcode项目模板的那个文件就好了。
你可以根据里面的代码、参数来调整 TemplateInfo.plist 的生成。
怎么自定义Xcode的项目模板？
请参考【LQS-App.xctemplate】。


【English】
When I wrote the Xcode project template, I found that if the template has many files, then I have to write a lot of things to the TemplateInfo.plist file, and there is a certain logical relationship, it is not so easy to manually write.
As a programmer, you are born to create tools to simplify your work and make everything foolish. Of course, the previous research is indispensable.
I have finally worked hard to understand how to customize the Xcode project template. Write this tool according to logic.
Why is it an iOS project? Because I know iOS best, so I used iOS to implement it. Try it in other languages.
Because it is the reason for the iOS project. You need to pull your folder into the document path of the emulator, and then execute the project, it will generate the TemplateInfo.plist file, and then overwrite the file of your Xcode project template.
You can adjust the generation of TemplateInfo.plist based on the code and parameters inside.
How to customize the Xcode project template?
Please refer to [LQS-App.xctemplate].
