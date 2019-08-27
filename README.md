# SimpleGallery
A really simple Image gallery app

### External Library Dependency
Cocoa-pods is used for dependency management. Pods directory is checked on the repository. This way, project can be run immediately after cloning and avoid possible compatibility conflicts for a resource installed with different version.

#### Installes Pods
- Firebase/Storage: For file storage
- Firebase/Auth: For user authentication
- Firebase/Core: Required by Firestore
- Firebase/Firestore: For database
- Kingfisher: For asynchronous	 image download and caching
- IHProgressHUD: For activity indication and operation result feedback


### Pattern and Bindable properties
MVVM pattern allow a better testability and layer abstraction for reusability. The Bindable class enable to bind UI updates depending on the data model changes or process status.


### No Storyboard file
Removing `Main.storyboard` and creating single `xib` files for views avoid massive storyboard files that can carry version conflicts. Also, it can benefit navigation abstraction and view reusability.


### Navigation
Using a `NavigatorProtocol` allows to create custom Navigators to handle controllers presentation, animation, and routing. Multiple Navigators could be created to work on each scope of the app (Authentication, Publications, etc.)


### Database
Gallery Files index is stored on Cloud Firestore.


### File Storage
Gallery Files are stored on Cloud Storage.


### TODO
- [ ] UI Tests
- [ ] Unit Tests
- [ ] Pick image from device Camera
- [ ] Image detail controller
- [ ] Better UI
- [ ] Localization Manager
- [ ] User Registration
- [ ] Session permission for file access

