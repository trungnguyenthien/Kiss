
import UIKit

extension UIColor {
    convenience init(rgb: UInt, a:CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: UInt) {
        self.init(rgb: rgb, a:1.0)
    }
}

class MaterialColor {

    // MARK: - red
    static var red50: UIColor {
        return UIColor(rgb: 0xffebee)
    }

    static var red100: UIColor {
        return UIColor(rgb: 0xffcdd2)
    }

    static var red200: UIColor {
        return UIColor(rgb: 0xef9a9a)
    }

    static var red300: UIColor {
        return UIColor(rgb: 0xe57373)
    }

    static var red400: UIColor {
        return UIColor(rgb: 0xef5350)
    }

    static var red500: UIColor {
        return UIColor(rgb: 0xf44336)
    }

    static var red600: UIColor {
        return UIColor(rgb: 0xe53935)
    }

    static var red700: UIColor {
        return UIColor(rgb: 0xd32f2f)
    }

    static var red800: UIColor {
        return UIColor(rgb: 0xc62828)
    }

    static var red900: UIColor {
        return UIColor(rgb: 0xb71c1c)
    }

    static var redA100: UIColor {
        return UIColor(rgb: 0xff8a80)
    }

    static var redA200: UIColor {
        return UIColor(rgb: 0xff5252)
    }

    static var redA400: UIColor {
        return UIColor(rgb: 0xff1744)
    }

    static var redA700: UIColor {
        return UIColor(rgb: 0xd50000)
    }

    // MARK: - pink
    static var pink50: UIColor {
        return UIColor(rgb: 0xfce4ec)
    }

    static var pink100: UIColor {
        return UIColor(rgb: 0xf8bbd0)
    }

    static var pink200: UIColor {
        return UIColor(rgb: 0xf48fb1)
    }

    static var pink300: UIColor {
        return UIColor(rgb: 0xf06292)
    }

    static var pink400: UIColor {
        return UIColor(rgb: 0xec407a)
    }

    static var pink500: UIColor {
        return UIColor(rgb: 0xe91e63)
    }

    static var pink600: UIColor {
        return UIColor(rgb: 0xd81b60)
    }

    static var pink700: UIColor {
        return UIColor(rgb: 0xc2185b)
    }

    static var pink800: UIColor {
        return UIColor(rgb: 0xad1457)
    }

    static var pink900: UIColor {
        return UIColor(rgb: 0x880e4f)
    }

    static var pinkA100: UIColor {
        return UIColor(rgb: 0xff80ab)
    }

    static var pinkA200: UIColor {
        return UIColor(rgb: 0xff4081)
    }

    static var pinkA400: UIColor {
        return UIColor(rgb: 0xf50057)
    }

    static var pinkA700: UIColor {
        return UIColor(rgb: 0xc51162)
    }

    // MARK: - purple
    static var purple50: UIColor {
        return UIColor(rgb: 0xf3e5f5)
    }

    static var purple100: UIColor {
        return UIColor(rgb: 0xe1bee7)
    }

    static var purple200: UIColor {
        return UIColor(rgb: 0xce93d8)
    }

    static var purple300: UIColor {
        return UIColor(rgb: 0xba68c8)
    }

    static var purple400: UIColor {
        return UIColor(rgb: 0xab47bc)
    }

    static var purple500: UIColor {
        return UIColor(rgb: 0x9c27b0)
    }

    static var purple600: UIColor {
        return UIColor(rgb: 0x8e24aa)
    }

    static var purple700: UIColor {
        return UIColor(rgb: 0x7b1fa2)
    }

    static var purple800: UIColor {
        return UIColor(rgb: 0x6a1b9a)
    }

    static var purple900: UIColor {
        return UIColor(rgb: 0x4a148c)
    }

    static var purpleA100: UIColor {
        return UIColor(rgb: 0xea80fc)
    }

    static var purpleA200: UIColor {
        return UIColor(rgb: 0xe040fb)
    }

    static var purpleA400: UIColor {
        return UIColor(rgb: 0xd500f9)
    }

    static var purpleA700: UIColor {
        return UIColor(rgb: 0xaa00ff)
    }

    // MARK: - deep-purple
    static var deepPurple50: UIColor {
        return UIColor(rgb: 0xede7f6)
    }

    static var deepPurple100: UIColor {
        return UIColor(rgb: 0xd1c4e9)
    }

    static var deepPurple200: UIColor {
        return UIColor(rgb: 0xb39ddb)
    }

    static var deepPurple300: UIColor {
        return UIColor(rgb: 0x9575cd)
    }

    static var deepPurple400: UIColor {
        return UIColor(rgb: 0x7e57c2)
    }

    static var deepPurple500: UIColor {
        return UIColor(rgb: 0x673ab7)
    }

    static var deepPurple600: UIColor {
        return UIColor(rgb: 0x5e35b1)
    }

    static var deepPurple700: UIColor {
        return UIColor(rgb: 0x512da8)
    }

    static var deepPurple800: UIColor {
        return UIColor(rgb: 0x4527a0)
    }

    static var deepPurple900: UIColor {
        return UIColor(rgb: 0x311b92)
    }

    static var deepPurpleA100: UIColor {
        return UIColor(rgb: 0xb388ff)
    }

    static var deepPurpleA200: UIColor {
        return UIColor(rgb: 0x7c4dff)
    }

    static var deepPurpleA400: UIColor {
        return UIColor(rgb: 0x651fff)
    }

    static var deepPurpleA700: UIColor {
        return UIColor(rgb: 0x6200ea)
    }

    // MARK: - indigo
    static var indigo50: UIColor {
        return UIColor(rgb: 0xe8eaf6)
    }

    static var indigo100: UIColor {
        return UIColor(rgb: 0xc5cae9)
    }

    static var indigo200: UIColor {
        return UIColor(rgb: 0x9fa8da)
    }

    static var indigo300: UIColor {
        return UIColor(rgb: 0x7986cb)
    }

    static var indigo400: UIColor {
        return UIColor(rgb: 0x5c6bc0)
    }

    static var indigo500: UIColor {
        return UIColor(rgb: 0x3f51b5)
    }

    static var indigo600: UIColor {
        return UIColor(rgb: 0x3949ab)
    }

    static var indigo700: UIColor {
        return UIColor(rgb: 0x303f9f)
    }

    static var indigo800: UIColor {
        return UIColor(rgb: 0x283593)
    }

    static var indigo900: UIColor {
        return UIColor(rgb: 0x1a237e)
    }

    static var indigoA100: UIColor {
        return UIColor(rgb: 0x8c9eff)
    }

    static var indigoA200: UIColor {
        return UIColor(rgb: 0x536dfe)
    }

    static var indigoA400: UIColor {
        return UIColor(rgb: 0x3d5afe)
    }

    static var indigoA700: UIColor {
        return UIColor(rgb: 0x304ffe)
    }

    // MARK: - blue
    static var blue50: UIColor {
        return UIColor(rgb: 0xe3f2fd)
    }

    static var blue100: UIColor {
        return UIColor(rgb: 0xbbdefb)
    }

    static var blue200: UIColor {
        return UIColor(rgb: 0x90caf9)
    }

    static var blue300: UIColor {
        return UIColor(rgb: 0x64b5f6)
    }

    static var blue400: UIColor {
        return UIColor(rgb: 0x42a5f5)
    }

    static var blue500: UIColor {
        return UIColor(rgb: 0x2196f3)
    }

    static var blue600: UIColor {
        return UIColor(rgb: 0x1e88e5)
    }

    static var blue700: UIColor {
        return UIColor(rgb: 0x1976d2)
    }

    static var blue800: UIColor {
        return UIColor(rgb: 0x1565c0)
    }

    static var blue900: UIColor {
        return UIColor(rgb: 0x0d47a1)
    }

    static var blueA100: UIColor {
        return UIColor(rgb: 0x82b1ff)
    }

    static var blueA200: UIColor {
        return UIColor(rgb: 0x448aff)
    }

    static var blueA400: UIColor {
        return UIColor(rgb: 0x2979ff)
    }

    static var blueA700: UIColor {
        return UIColor(rgb: 0x2962ff)
    }

    // MARK: - light-blue
    static var lightBlue50: UIColor {
        return UIColor(rgb: 0xe1f5fe)
    }

    static var lightBlue100: UIColor {
        return UIColor(rgb: 0xb3e5fc)
    }

    static var lightBlue200: UIColor {
        return UIColor(rgb: 0x81d4fa)
    }

    static var lightBlue300: UIColor {
        return UIColor(rgb: 0x4fc3f7)
    }

    static var lightBlue400: UIColor {
        return UIColor(rgb: 0x29b6f6)
    }

    static var lightBlue500: UIColor {
        return UIColor(rgb: 0x03a9f4)
    }

    static var lightBlue600: UIColor {
        return UIColor(rgb: 0x039be5)
    }

    static var lightBlue700: UIColor {
        return UIColor(rgb: 0x0288d1)
    }

    static var lightBlue800: UIColor {
        return UIColor(rgb: 0x0277bd)
    }

    static var lightBlue900: UIColor {
        return UIColor(rgb: 0x01579b)
    }

    static var lightBlueA100: UIColor {
        return UIColor(rgb: 0x80d8ff)
    }

    static var lightBlueA200: UIColor {
        return UIColor(rgb: 0x40c4ff)
    }

    static var lightBlueA400: UIColor {
        return UIColor(rgb: 0x00b0ff)
    }

    static var lightBlueA700: UIColor {
        return UIColor(rgb: 0x0091ea)
    }

    // MARK: - cyan
    static var cyan50: UIColor {
        return UIColor(rgb: 0xe0f7fa)
    }

    static var cyan100: UIColor {
        return UIColor(rgb: 0xb2ebf2)
    }

    static var cyan200: UIColor {
        return UIColor(rgb: 0x80deea)
    }

    static var cyan300: UIColor {
        return UIColor(rgb: 0x4dd0e1)
    }

    static var cyan400: UIColor {
        return UIColor(rgb: 0x26c6da)
    }

    static var cyan500: UIColor {
        return UIColor(rgb: 0x00bcd4)
    }

    static var cyan600: UIColor {
        return UIColor(rgb: 0x00acc1)
    }

    static var cyan700: UIColor {
        return UIColor(rgb: 0x0097a7)
    }

    static var cyan800: UIColor {
        return UIColor(rgb: 0x00838f)
    }

    static var cyan900: UIColor {
        return UIColor(rgb: 0x006064)
    }

    static var cyanA100: UIColor {
        return UIColor(rgb: 0x84ffff)
    }

    static var cyanA200: UIColor {
        return UIColor(rgb: 0x18ffff)
    }

    static var cyanA400: UIColor {
        return UIColor(rgb: 0x00e5ff)
    }

    static var cyanA700: UIColor {
        return UIColor(rgb: 0x00b8d4)
    }

    // MARK: - teal
    static var teal50: UIColor {
        return UIColor(rgb: 0xe0f2f1)
    }

    static var teal100: UIColor {
        return UIColor(rgb: 0xb2dfdb)
    }

    static var teal200: UIColor {
        return UIColor(rgb: 0x80cbc4)
    }

    static var teal300: UIColor {
        return UIColor(rgb: 0x4db6ac)
    }

    static var teal400: UIColor {
        return UIColor(rgb: 0x26a69a)
    }

    static var teal500: UIColor {
        return UIColor(rgb: 0x009688)
    }

    static var teal600: UIColor {
        return UIColor(rgb: 0x00897b)
    }

    static var teal700: UIColor {
        return UIColor(rgb: 0x00796b)
    }

    static var teal800: UIColor {
        return UIColor(rgb: 0x00695c)
    }

    static var teal900: UIColor {
        return UIColor(rgb: 0x004d40)
    }

    static var tealA100: UIColor {
        return UIColor(rgb: 0xa7ffeb)
    }

    static var tealA200: UIColor {
        return UIColor(rgb: 0x64ffda)
    }

    static var tealA400: UIColor {
        return UIColor(rgb: 0x1de9b6)
    }

    static var tealA700: UIColor {
        return UIColor(rgb: 0x00bfa5)
    }

    // MARK: - green
    static var green50: UIColor {
        return UIColor(rgb: 0xe8f5e9)
    }

    static var green100: UIColor {
        return UIColor(rgb: 0xc8e6c9)
    }

    static var green200: UIColor {
        return UIColor(rgb: 0xa5d6a7)
    }

    static var green300: UIColor {
        return UIColor(rgb: 0x81c784)
    }

    static var green400: UIColor {
        return UIColor(rgb: 0x66bb6a)
    }

    static var green500: UIColor {
        return UIColor(rgb: 0x4caf50)
    }

    static var green600: UIColor {
        return UIColor(rgb: 0x43a047)
    }

    static var green700: UIColor {
        return UIColor(rgb: 0x388e3c)
    }

    static var green800: UIColor {
        return UIColor(rgb: 0x2e7d32)
    }

    static var green900: UIColor {
        return UIColor(rgb: 0x1b5e20)
    }

    static var greenA100: UIColor {
        return UIColor(rgb: 0xb9f6ca)
    }

    static var greenA200: UIColor {
        return UIColor(rgb: 0x69f0ae)
    }

    static var greenA400: UIColor {
        return UIColor(rgb: 0x00e676)
    }

    static var greenA700: UIColor {
        return UIColor(rgb: 0x00c853)
    }

    // MARK: - light-green
    static var lightGreen50: UIColor {
        return UIColor(rgb: 0xf1f8e9)
    }

    static var lightGreen100: UIColor {
        return UIColor(rgb: 0xdcedc8)
    }

    static var lightGreen200: UIColor {
        return UIColor(rgb: 0xc5e1a5)
    }

    static var lightGreen300: UIColor {
        return UIColor(rgb: 0xaed581)
    }

    static var lightGreen400: UIColor {
        return UIColor(rgb: 0x9ccc65)
    }

    static var lightGreen500: UIColor {
        return UIColor(rgb: 0x8bc34a)
    }

    static var lightGreen600: UIColor {
        return UIColor(rgb: 0x7cb342)
    }

    static var lightGreen700: UIColor {
        return UIColor(rgb: 0x689f38)
    }

    static var lightGreen800: UIColor {
        return UIColor(rgb: 0x558b2f)
    }

    static var lightGreen900: UIColor {
        return UIColor(rgb: 0x33691e)
    }

    static var lightGreenA100: UIColor {
        return UIColor(rgb: 0xccff90)
    }

    static var lightGreenA200: UIColor {
        return UIColor(rgb: 0xb2ff59)
    }

    static var lightGreenA400: UIColor {
        return UIColor(rgb: 0x76ff03)
    }

    static var lightGreenA700: UIColor {
        return UIColor(rgb: 0x64dd17)
    }

    // MARK: - lime
    static var lime50: UIColor {
        return UIColor(rgb: 0xf9fbe7)
    }

    static var lime100: UIColor {
        return UIColor(rgb: 0xf0f4c3)
    }

    static var lime200: UIColor {
        return UIColor(rgb: 0xe6ee9c)
    }

    static var lime300: UIColor {
        return UIColor(rgb: 0xdce775)
    }

    static var lime400: UIColor {
        return UIColor(rgb: 0xd4e157)
    }

    static var lime500: UIColor {
        return UIColor(rgb: 0xcddc39)
    }

    static var lime600: UIColor {
        return UIColor(rgb: 0xc0ca33)
    }

    static var lime700: UIColor {
        return UIColor(rgb: 0xafb42b)
    }

    static var lime800: UIColor {
        return UIColor(rgb: 0x9e9d24)
    }

    static var lime900: UIColor {
        return UIColor(rgb: 0x827717)
    }

    static var limeA100: UIColor {
        return UIColor(rgb: 0xf4ff81)
    }

    static var limeA200: UIColor {
        return UIColor(rgb: 0xeeff41)
    }

    static var limeA400: UIColor {
        return UIColor(rgb: 0xc6ff00)
    }

    static var limeA700: UIColor {
        return UIColor(rgb: 0xaeea00)
    }

    // MARK: - yellow
    static var yellow50: UIColor {
        return UIColor(rgb: 0xfffde7)
    }

    static var yellow100: UIColor {
        return UIColor(rgb: 0xfff9c4)
    }

    static var yellow200: UIColor {
        return UIColor(rgb: 0xfff59d)
    }

    static var yellow300: UIColor {
        return UIColor(rgb: 0xfff176)
    }

    static var yellow400: UIColor {
        return UIColor(rgb: 0xffee58)
    }

    static var yellow500: UIColor {
        return UIColor(rgb: 0xffeb3b)
    }

    static var yellow600: UIColor {
        return UIColor(rgb: 0xfdd835)
    }

    static var yellow700: UIColor {
        return UIColor(rgb: 0xfbc02d)
    }

    static var yellow800: UIColor {
        return UIColor(rgb: 0xf9a825)
    }

    static var yellow900: UIColor {
        return UIColor(rgb: 0xf57f17)
    }

    static var yellowA100: UIColor {
        return UIColor(rgb: 0xffff8d)
    }

    static var yellowA200: UIColor {
        return UIColor(rgb: 0xffff00)
    }

    static var yellowA400: UIColor {
        return UIColor(rgb: 0xffea00)
    }

    static var yellowA700: UIColor {
        return UIColor(rgb: 0xffd600)
    }

    // MARK: - amber
    static var amber50: UIColor {
        return UIColor(rgb: 0xfff8e1)
    }

    static var amber100: UIColor {
        return UIColor(rgb: 0xffecb3)
    }

    static var amber200: UIColor {
        return UIColor(rgb: 0xffe082)
    }

    static var amber300: UIColor {
        return UIColor(rgb: 0xffd54f)
    }

    static var amber400: UIColor {
        return UIColor(rgb: 0xffca28)
    }

    static var amber500: UIColor {
        return UIColor(rgb: 0xffc107)
    }

    static var amber600: UIColor {
        return UIColor(rgb: 0xffb300)
    }

    static var amber700: UIColor {
        return UIColor(rgb: 0xffa000)
    }

    static var amber800: UIColor {
        return UIColor(rgb: 0xff8f00)
    }

    static var amber900: UIColor {
        return UIColor(rgb: 0xff6f00)
    }

    static var amberA100: UIColor {
        return UIColor(rgb: 0xffe57f)
    }

    static var amberA200: UIColor {
        return UIColor(rgb: 0xffd740)
    }

    static var amberA400: UIColor {
        return UIColor(rgb: 0xffc400)
    }

    static var amberA700: UIColor {
        return UIColor(rgb: 0xffab00)
    }

    // MARK: - orange
    static var orange50: UIColor {
        return UIColor(rgb: 0xfff3e0)
    }

    static var orange100: UIColor {
        return UIColor(rgb: 0xffe0b2)
    }

    static var orange200: UIColor {
        return UIColor(rgb: 0xffcc80)
    }

    static var orange300: UIColor {
        return UIColor(rgb: 0xffb74d)
    }

    static var orange400: UIColor {
        return UIColor(rgb: 0xffa726)
    }

    static var orange500: UIColor {
        return UIColor(rgb: 0xff9800)
    }

    static var orange600: UIColor {
        return UIColor(rgb: 0xfb8c00)
    }

    static var orange700: UIColor {
        return UIColor(rgb: 0xf57c00)
    }

    static var orange800: UIColor {
        return UIColor(rgb: 0xef6c00)
    }

    static var orange900: UIColor {
        return UIColor(rgb: 0xe65100)
    }

    static var orangeA100: UIColor {
        return UIColor(rgb: 0xffd180)
    }

    static var orangeA200: UIColor {
        return UIColor(rgb: 0xffab40)
    }

    static var orangeA400: UIColor {
        return UIColor(rgb: 0xff9100)
    }

    static var orangeA700: UIColor {
        return UIColor(rgb: 0xff6d00)
    }

    // MARK: - deep-orange
    static var deepOrange50: UIColor {
        return UIColor(rgb: 0xfbe9e7)
    }

    static var deepOrange100: UIColor {
        return UIColor(rgb: 0xffccbc)
    }

    static var deepOrange200: UIColor {
        return UIColor(rgb: 0xffab91)
    }

    static var deepOrange300: UIColor {
        return UIColor(rgb: 0xff8a65)
    }

    static var deepOrange400: UIColor {
        return UIColor(rgb: 0xff7043)
    }

    static var deepOrange500: UIColor {
        return UIColor(rgb: 0xff5722)
    }

    static var deepOrange600: UIColor {
        return UIColor(rgb: 0xf4511e)
    }

    static var deepOrange700: UIColor {
        return UIColor(rgb: 0xe64a19)
    }

    static var deepOrange800: UIColor {
        return UIColor(rgb: 0xd84315)
    }

    static var deepOrange900: UIColor {
        return UIColor(rgb: 0xbf360c)
    }

    static var deepOrangeA100: UIColor {
        return UIColor(rgb: 0xff9e80)
    }

    static var deepOrangeA200: UIColor {
        return UIColor(rgb: 0xff6e40)
    }

    static var deepOrangeA400: UIColor {
        return UIColor(rgb: 0xff3d00)
    }

    static var deepOrangeA700: UIColor {
        return UIColor(rgb: 0xdd2c00)
    }

    // MARK: - brown
    static var brown50: UIColor {
        return UIColor(rgb: 0xefebe9)
    }

    static var brown100: UIColor {
        return UIColor(rgb: 0xd7ccc8)
    }

    static var brown200: UIColor {
        return UIColor(rgb: 0xbcaaa4)
    }

    static var brown300: UIColor {
        return UIColor(rgb: 0xa1887f)
    }

    static var brown400: UIColor {
        return UIColor(rgb: 0x8d6e63)
    }

    static var brown500: UIColor {
        return UIColor(rgb: 0x795548)
    }

    static var brown600: UIColor {
        return UIColor(rgb: 0x6d4c41)
    }

    static var brown700: UIColor {
        return UIColor(rgb: 0x5d4037)
    }

    static var brown800: UIColor {
        return UIColor(rgb: 0x4e342e)
    }

    static var brown900: UIColor {
        return UIColor(rgb: 0x3e2723)
    }

    // MARK: - grey
    static var grey50: UIColor {
        return UIColor(rgb: 0xfafafa)
    }

    static var grey100: UIColor {
        return UIColor(rgb: 0xf5f5f5)
    }

    static var grey200: UIColor {
        return UIColor(rgb: 0xeeeeee)
    }

    static var grey300: UIColor {
        return UIColor(rgb: 0xe0e0e0)
    }

    static var grey400: UIColor {
        return UIColor(rgb: 0xbdbdbd)
    }

    static var grey500: UIColor {
        return UIColor(rgb: 0x9e9e9e)
    }

    static var grey600: UIColor {
        return UIColor(rgb: 0x757575)
    }

    static var grey700: UIColor {
        return UIColor(rgb: 0x616161)
    }

    static var grey800: UIColor {
        return UIColor(rgb: 0x424242)
    }

    static var grey900: UIColor {
        return UIColor(rgb: 0x212121)
    }

    // MARK: - blue-grey
    static var blueGrey50: UIColor {
        return UIColor(rgb: 0xeceff1)
    }

    static var blueGrey100: UIColor {
        return UIColor(rgb: 0xcfd8dc)
    }

    static var blueGrey200: UIColor {
        return UIColor(rgb: 0xb0bec5)
    }

    static var blueGrey300: UIColor {
        return UIColor(rgb: 0x90a4ae)
    }

    static var blueGrey400: UIColor {
        return UIColor(rgb: 0x78909c)
    }

    static var blueGrey500: UIColor {
        return UIColor(rgb: 0x607d8b)
    }

    static var blueGrey600: UIColor {
        return UIColor(rgb: 0x546e7a)
    }

    static var blueGrey700: UIColor {
        return UIColor(rgb: 0x455a64)
    }

    static var blueGrey800: UIColor {
        return UIColor(rgb: 0x37474f)
    }

    static var blueGrey900: UIColor {
        return UIColor(rgb: 0x263238)
    }

    // MARK: - black
    static var black: UIColor {
        return UIColor(rgb: 0x000000)
    }

    // MARK: - white
    static var white: UIColor {
        return UIColor(rgb: 0xffffff)
    }
}
