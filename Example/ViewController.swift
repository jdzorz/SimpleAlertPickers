import UIKit
import SafariServices
import Photos

class ViewController: UIViewController {
    
    // MARK: Enums
    
    enum AlertType: String {
        
        case simple = "Simple"
        case simpleWithImages = "Simple +Images"
        case oneTextField = "One TextField"
        case twoTextFields = "Login form"
        case dataPicker = "Date Picker"
        case pickerView = "Picker View"
        case countryPicker = "Country Picker"
        case phoneCodePicker = "Phone Code Picker"
        case currencyPicker = "Currency Picker"
        case colorPicker = "Color Picker"
        case textViewer = "Text Viewer"

        
        var description: String {
            switch self {
            case .simple: return "3 different buttons"
            case .simpleWithImages: return "3 buttons with image"
            case .dataPicker: return "Select date and time"
            case .pickerView: return "Select alert's main view height"
            case .oneTextField: return "Input text"
            case .twoTextFields: return "2 TextFields"
            case .countryPicker: return "TableView"
            case .phoneCodePicker: return "TableView"
            case .currencyPicker: return "TableView"
            case .colorPicker: return "Storyboard & Autolayout"
            case .textViewer: return "TextView, not editable"
            }
        }
        
        var color: UIColor? {
            switch self {
            case .simple, .simpleWithImages:
                return UIColor(hex: 0x007AFF)
            case .oneTextField, .twoTextFields:
                return UIColor(hex: 0x5AC8FA)
            case .dataPicker, .pickerView:
                return UIColor(hex: 0x4CD964)
            case .countryPicker, .phoneCodePicker, .currencyPicker, .textViewer:
                return UIColor(hex: 0xFF5722)
            case .colorPicker:
                return nil
            }
        }
    }
    
    fileprivate lazy var alerts: [AlertType] = [
        .simple,
        .simpleWithImages,
        .oneTextField,
        .twoTextFields,
        .dataPicker,
        .pickerView,
        .countryPicker,
        .phoneCodePicker,
        .currencyPicker,
        .colorPicker,
        .textViewer,
    ]
    
    // MARK: UI Metrics
    
    struct UI {
        static let itemHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 88 : 65
        static let lineSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 28 : 20
        static let xInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
        static let topInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 28
    }
    
    
    // MARK: Properties
    
    private var alertIconCollection = AlertIconCollection()
    
    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    
    fileprivate lazy var segments: SegmentedControl = {
        let styles: [String] = ["Alert", "ActionSheet"]
        $0.segmentTitles = styles
        $0.action { [unowned self] index in
            switch styles[index] {
            case "Alert":           self.alertStyle = .alert
            case "ActionSheet":     self.alertStyle = .actionSheet
            default: break }
        }
        $0.tintColor = UIColor(hex: 0xFF2DC6)//UIColor(hex: 0x3C3C3C)
        return $0
    }(SegmentedControl())
    
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.register(TypeOneCell.self, forCellWithReuseIdentifier: TypeOneCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = UIScrollView.DecelerationRate.fast
        //$0.contentInsetAdjustmentBehavior = .never
        $0.bounces = true
        $0.backgroundColor = .white
        //$0.maskToBounds = false
        //$0.clipsToBounds = false
        $0.contentInset.bottom = UI.itemHeight
        return $0
        }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    fileprivate lazy var layout: VerticalScrollFlowLayout = {
        $0.minimumLineSpacing = UI.lineSpacing
        $0.sectionInset = UIEdgeInsets(top: UI.topInset, left: 0, bottom: 0, right: 0)
        $0.itemSize = itemSize
        
        return $0
    }(VerticalScrollFlowLayout())
    
    fileprivate var itemSize: CGSize {
        let width = UIScreen.main.bounds.width - 2 * UI.xInset
        return CGSize(width: width, height: UI.itemHeight)
    }
    
    // MARK: Initialize
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewController LifeCycle
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Alerts & Pickers"
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            //navigationItem.largeTitleDisplayMode = .always
        }
        
        layout.itemSize = itemSize
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        
        navigationItem.titleView = segments
        alertStyle = .actionSheet
        segments.selectedSegmentIndex = 1
    }
    
    func show(alert type: AlertType) {
        switch type {
            
        case .simple:
            let alert = UIAlertController(title: "Simple Alert", message: "3 kinds of actions", preferredStyle: self.alertStyle)
            alert.addAction(title: "Default", style: .default)
            alert.addAction(title: "Cancel", style: .cancel)
            alert.addAction(title: "Destructive", style: .destructive)
            alert.show()
            
        case .simpleWithImages:
            let alert = UIAlertController(style: self.alertStyle)
            alert.set(title: "Simple Alert", font: .systemFont(ofSize: 20), color: UIColor(hex: 0xFF2D55))
            alert.set(message: "3 kinds of actions with images", font: .systemFont(ofSize: 14), color: UIColor(hex: 0xFF9500))
            alert.addAction(image: #imageLiteral(resourceName: "clip"), title: "Attache File", color: UIColor(hex: 0xFF2DC6), style: .default)
            alert.addAction(title: "Cancel", style: .cancel) //.cancel action will always be at the end
            alert.addAction(image: #imageLiteral(resourceName: "login"), title: "Login", style: .destructive, isEnabled: false)
            alert.show()
            
        case .oneTextField:
            let alert = UIAlertController(title: "TextField", message: "Secure Entry", preferredStyle: self.alertStyle)
            
            let textField: TextField.Config = { textField in
                textField.left(image: #imageLiteral(resourceName: "pen"), color: .black)
                textField.leftViewPadding = 12
                textField.becomeFirstResponder()
                textField.layer.borderWidth = 1
                textField.layer.cornerRadius = 8
                textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.placeholder = "Type something"
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                //textField.isSecureTextEntry = true
                textField.returnKeyType = .done
                textField.action { textField in
                    Log("textField = \(String(describing: textField.text))")
                }
            }
            
            alert.addOneTextField(configuration: textField)
            
            alert.addAction(title: "OK".localized, style: .cancel)
            alert.show()
            
        case .twoTextFields:
            let alert = UIAlertController(style: self.alertStyle)
            
            let textFieldOne: TextField.Config = { textField in
                textField.left(image: #imageLiteral(resourceName: "user"), color: UIColor(hex: 0x007AFF))
                textField.leftViewPadding = 16
                textField.leftTextPadding = 12
                textField.becomeFirstResponder()
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.placeholder = "Name"
                textField.clearButtonMode = .whileEditing
                textField.autocapitalizationType = .none
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.returnKeyType = .continue
                textField.action { textField in
                    Log("textField = \(String(describing: textField.text))")
                }
            }
            
            let textFieldTwo: TextField.Config = { textField in
                textField.left(image: #imageLiteral(resourceName: "padlock"), color: UIColor(hex: 0x007AFF))
                textField.leftViewPadding = 16
                textField.leftTextPadding = 12
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.placeholder = "Password"
                textField.clearsOnBeginEditing = true
                textField.autocapitalizationType = .none
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.isSecureTextEntry = true
                textField.returnKeyType = .done
                textField.action { textField in
                    Log("textField = \(String(describing: textField.text))")
                }
            }
            
            alert.addTwoTextFields(
                height: self.alertStyle == .alert ? 44 : 58,
                hInset: self.alertStyle == .alert ? 12 : 0,
                vInset: self.alertStyle == .alert ? 12 : 0,
                textFieldOne: textFieldOne,
                textFieldTwo: textFieldTwo)
            
            alert.addAction(title: "Sign in", style: .cancel)
            alert.show()
            
        case .dataPicker:
            let alert = UIAlertController(title: "Date Picker", message: "Select Date", preferredStyle: self.alertStyle)
            alert.addDatePicker(mode: .dateAndTime, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                Log(date)
            }
            alert.addAction(title: "Done".localized, style: .cancel)
            alert.show()
            
        case .pickerView:
            let alert = UIAlertController(title: "Picker View", message: "Preferred Content Height", preferredStyle: self.alertStyle)
            
            let frameSizes: [CGFloat] = (150...300).map { CGFloat($0) }
            let pickerViewValues: [[String]] = [frameSizes.map { Int($0).description }]
            let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.index(of: 216) ?? 0)
            
            alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue, withSerchBar: true) { vc, picker, index, values  in
                
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0) {
                        vc.preferredContentSize.height = frameSizes[index.row]
                    }
                }
            }
            alert.addAction(title: "Done".localized, style: .cancel)
            alert.show()
            
        case .countryPicker:
            let alert = UIAlertController(style: self.alertStyle)
            alert.addLocalePicker(type: .country) { info in Log(info) }
            alert.addAction(title: "Cancel".localized, style: .cancel)
            alert.show()
            
        case .phoneCodePicker:
            let alert = UIAlertController(style: self.alertStyle)
            alert.addLocalePicker(type: .phoneCode) { info in Log(info) }
            alert.addAction(title: "Cancel".localized, style: .cancel)
            alert.show()
            
        case .currencyPicker:
            let alert = UIAlertController(style: self.alertStyle)
            alert.addLocalePicker(type: .currency) { info in Log(info) }
            alert.addAction(title: "Cancel".localized, style: .cancel)
            alert.show()
                        
        case .colorPicker:
            let alert = UIAlertController(style: self.alertStyle)
            alert.addColorPicker(color: UIColor(hex: 0xFF2DC6)) { color in Log(color) }
            alert.addAction(title: "Cancel".localized, style: .cancel)
            alert.show()
            
        case .textViewer:
            let alert = UIAlertController(style: self.alertStyle)
            
            let text: [AttributedTextBlock] = [
                .normal(""),
                .header1("U.S. Returns & Refunds Policy."),
                .header2("Standard Return Policy."),
                .normal("There are a few important things to keep in mind when returning a product you purchased online from Apple:"),
                .list("You have 14 calendar days to return an item from the date you received it."),
                .list("Only items that have been purchased directly from Apple, either online or at an Apple Retail Store, can be returned to Apple. Apple products purchased through other retailers must be returned in accordance with their respective returns and refunds policy."),
                .list("Please ensure that the item you're returning is repackaged with all the cords, adapters and documentation that were included when you received it."),
                .normal("There are some items, however, that are ineligible for return, including:"),
                .list("Opened software"),
                .list("Electronic Software Downloads"),
                .list("Software Up-to-Date Program Products (software upgrades)"),
                .list("Apple Store Gift Cards"),
                .list("Apple Developer products (membership, technical support incidents, WWDC tickets)"),
                .list("Apple Print Products"),
                .normal("*You can return software, provided that it has not been installed on any computer. Software that contains a printed software license may not be returned if the seal or sticker on the software media packaging is broken.")]
            alert.addTextViewer(text: .attributedText(text))
            alert.addAction(title: "OK".localized, style: .cancel)
            alert.show()
            
        }
    }
}

// MARK: - CollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log("selected alert - \(alerts[indexPath.item].rawValue)")
        show(alert: alerts[indexPath.item])
    }
}

// MARK: - CollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: TypeOneCell.identifier, for: indexPath) as? TypeOneCell else { return UICollectionViewCell() }
        
        let alert = alerts[indexPath.item]

        item.imageView.image = alertIconCollection.icon(alertType: alert)
        item.imageView.tintColor = alert.color
        item.imageView.contentMode = .scaleAspectFit
        item.title.text = alert.rawValue
        item.subtitle.text = alert.description
        item.subtitle.textColor = .darkGray
        
        return item
    }
}
