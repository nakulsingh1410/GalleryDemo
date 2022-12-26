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

    // MARK: - Properties

    let viewModel: GalleryViewModelProtocol = GalleryViewModel()


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData()
    }
    
    private func configureUI() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }
    
    private func loadData() {
        // Search for the top images of the week
        viewModel.searchTopImagesOfTheWeek { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(error)
            } else {
                // Reload the table view to display the new images
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as? ImageTableViewCell else {
            return UITableViewCell()
        }
        cell.galleryData = viewModel.image(at: indexPath.row)
        return cell
    }

}
