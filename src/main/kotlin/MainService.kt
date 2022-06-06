class MainService(
    private val subService: SubService
) {
    fun sayHello() = "Hello from the REAL MainService - ${subService.sayHello()}"
}