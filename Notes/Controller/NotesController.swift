

import UIKit

class NotesController: UITableViewController {
    
    private let cellId = "cellId"
    var notes = [Note]()
    
    //khởi tạo 1 set kiểu Int rỗng
    var selectedNoteIndexes = Set<Int>()

    var editMode = false {
        //nếu cái giá trị của biến thay đổi , nó sẽ gọi didSet
        didSet {
            let sortedIndexes = Array(self.selectedNoteIndexes).sorted().reversed()
            sortedIndexes.forEach { (index) in
                notes?.remove(at: index)
            }
            self.selectedNoteIndexes = []
            self.tableView.reloadData()
        }
    }
    
    var deleteButton: UIBarButtonItem!
    
    var editedNoteIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ghi chú"

        self.deleteButton = UIBarButtonItem(title: "Xoá", style: .done, target: self, action: #selector(del))
        self.navigationItem.rightBarButtonItem = self.deleteButton
      
        tableView.register(NoteCell.self, forCellReuseIdentifier: cellId)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVC))
        
    }
    @objc func addVC(){
        //b5 : sử dụng delegate
        let mainVC = ViewScreen()
        mainVC.myDelegate = self
        navigationController?.pushViewController(mainVC, animated: true)
    }
    @objc func del(){
        self.editMode.toggle()
        self.deleteButton.title = self.editMode ? "Xong" : "Xoá"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NoteCell
        
        cell.titleLbl.text = notes[indexPath.row].title
        cell.dateLabel.text = notes[indexPath.row].date
        cell.selectButton.isHidden = !self.editMode
       
     
    let image = self.selectedNoteIndexes.contains(indexPath.row) ?
        //nếu selectedNoteIndexes chứa index của cell đấy thì hiện ảnh checked
        UIImage(named: "checked")?.withRenderingMode(.alwaysOriginal):
        //ko chứa thì hiện ảnh uncheck
        UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        cell.selectButton.setImage(image, for: .normal)
        
        cell.indexPath = indexPath
        //b3 : đoạn này để hứng cloruse từ màn muốn nhận
        cell.selectAction = { [weak self] ip in
            self?.tapOnNote(indexPath: indexPath)
    
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.editMode {
            self.tapOnNote(indexPath: indexPath)
        } else {
            self.editedNoteIndexPath = indexPath
            let selectedNote = self.notes[indexPath.row]
            print(selectedNote)
            let editNotesVC = EditNotesVC()
            editNotesVC.note = selectedNote
            editNotesVC.myDelegateEdit = self
            
            navigationController?.pushViewController(editNotesVC, animated: true)
        }
}
   
    //hàm này sẽ kiểm tra xem cái note mà được chạm vào đã được chọn chưa
    func tapOnNote(indexPath: IndexPath) {
        let index = indexPath.row
        if self.selectedNoteIndexes.contains(index) {
            self.selectedNoteIndexes.remove(index)
        } else {
            self.selectedNoteIndexes.insert(index)
        }
        //rồi reload cái row được chạm
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        //khi reload cái row được chạm tableView sẽ gọi lại cái hàm cellForRow của cái row đấy
        //và trong hàm cellForRow mình code là
    }
    
}

//b6 : kế thừa delegate
extension NotesController : MyDelegateAppend {
    func getdataAppend(dulieu: Note) {
        self.notes.append(dulieu)
        self.tableView.reloadData()
    }
}


extension NotesController : MyDelegateEdit {
    func getdataEdit(dulieu: Note) {
        if let indexPath = self.editedNoteIndexPath {
            self.notes[indexPath.row] = dulieu
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.editedNoteIndexPath = nil
        }
    }
}
