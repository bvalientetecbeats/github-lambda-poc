import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*

internal class MainServiceTest {

    private val subService: SubService = mockk()

    private val testService = MainService(subService)

    @Test
    fun `call sayHello() with mocked sub service`() {
        every { subService.sayHello() } returns "Hello from MOCKED SubService"

        val result = testService.sayHello()

        assertEquals(result,"Hello from the REAL MainService - Hello from MOCKED SubService")
    }
}