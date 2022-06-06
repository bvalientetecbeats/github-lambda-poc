import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*

internal class MyClassTest {

    private val myClass: MyClass = MyClass()

    @Test
    fun sum() {
        val expected = 42
        assertEquals(expected, myClass.sum(40, 2))
    }
}