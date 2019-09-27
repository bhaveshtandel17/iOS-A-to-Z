

import UIKit

class XMainViewController: UIViewController {
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var itemAdd: UIBarButtonItem!
    
    private var collagePhotos: [UIImage] = [] {
        didSet {
            self.updateUI(photos: collagePhotos)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collagePhotos = []
    }
    
    private func updateUI(photos: [UIImage]) {
        buttonSave.isEnabled = photos.count > 0 && photos.count % 2 == 0
        buttonClear.isEnabled = photos.count > 0
        itemAdd.isEnabled = photos.count < 6
        title = photos.count > 0 ? "\(photos.count) photos" : "Collage"
        imagePreview.image = photos.collage(size: imagePreview.frame.size)
    }
    
    @IBAction func actionClear() {
        self.collagePhotos = []
    }
    
    @IBAction func actionSave() {
        guard let image = imagePreview.image else { return }
        XPhotoWriter.save(image) { [weak self] (id, error) in
            if let imageID = id {
                self?.showMessage("Saved woth id:\(imageID)")
                self?.actionClear()
            } else if let fileSaveError = error {
                self?.showMessage("Error", description: fileSaveError.localizedDescription)
            }
            
        }
    }
    
    @IBAction func actionAdd() {
        let photosViewController = storyboard!.instantiateViewController(
            withIdentifier: "PhotosViewController") as! XPhotosViewController
        
        photosViewController.deleagate = self
        navigationController!.pushViewController(photosViewController, animated: true)
    }
    
    func showMessage(_ title: String, description: String? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }
}

extension XMainViewController: XPhotosViewControllerDelegate {
    func didSelected(photo: UIImage) {
        var newCollagePhotos = self.collagePhotos
        newCollagePhotos.append(photo)
        self.collagePhotos = newCollagePhotos
    }
}
