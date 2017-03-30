# GDevTextField

`GDevTextField` is a nice, flexible and customizable text field. This design is based on [Google's Material Design](https://material.io/guidelines/#) and is very much customizable and extensible.

![](http://i65.tinypic.com/3462tfd.gif)

## Compatibility

`GDevTextField` is compatible with Swift 3.

## Installation

You can download the project from `Github` and after doing so, copy the files in the `Sources` folder to your project.

## Usage

### Interface Builder

Most of the `GDevTextField's` properties are editable by the interface builder. This makes it much faster and easier to use. All you have to do is drag a UITextField and change it's Class to GDevTextField as shown below.

![](http://i65.tinypic.com/flan0l.png)

After that, you will be able to see IBDesignables properties on xcode as shown below.

![](http://i67.tinypic.com/2d0jar7.png)

### Code

```swift
let textField = GDevTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
textField.titleText = "Name"
textField.placeholder = "Name"
self.view.addSubview(textField)
```

## Contributing

All contributions are welcome.
