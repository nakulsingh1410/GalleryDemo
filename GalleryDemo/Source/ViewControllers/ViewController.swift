//
//  ViewController.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    enum PresentationStyle {
        case list
        case grid
    }

    
    // MARK: - Properties

    let viewModel: GalleryViewModelProtocol = GalleryViewModel()
    var presentationStyle: PresentationStyle = .list

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData(text: "")
    }

    private func configureUI() {
        // Register the cell XIBs
        tableView.register(UINib(nibName: "GalleryListCell", bundle: nil), forCellReuseIdentifier: "GalleryListCell")
        collectionView.register(UINib(nibName: "GalleryGridCell", bundle: nil), forCellWithReuseIdentifier: "GalleryGridCell")
        
        // Set the data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Set the estimated item size
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - Private Methods
    
    private func loadData(text: String) {
        // Search for the top images of the week
        activityIndicator.startAnimating()
        viewModel.searchTopImagesOfTheWeek(searchText: text) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(error)
            } else {
                // Reload the table view to display the new images
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.updateUI()
                }
            }
        }
    }

    private func updateUI() {
        if presentationStyle == .list {
            tableView.isHidden = false
            collectionView.isHidden = true
            tableView.reloadData()
        } else {
            tableView.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }

    // MARK: - IBActions
    
    @IBAction func gridToListBtnTapped(sender: UIButton) {
        if presentationStyle == .list {
            presentationStyle = .grid
            sender.setTitle("List", for: .normal)
        } else {
            presentationStyle = .list
            sender.setTitle("Grid", for: .normal)
        }
        updateUI()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryListCell") as? GalleryListCell else {
            return UITableViewCell()
        }
        cell.galleryData = viewModel.image(at: indexPath.row)
        return cell
    }

}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryGridCell", for: indexPath) as? GalleryGridCell else {
            return UICollectionViewCell()
        }
        cell.galleryData = viewModel.image(at: indexPath.row)
        return cell
    }

}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width: widthPerItem, height: 250.0)
    }
}
