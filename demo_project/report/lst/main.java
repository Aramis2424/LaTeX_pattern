import java.util.*;
// Пример Java25 (ну и кириллицы в коде)
void main() {
    var users = List.of(new User("Anna", 25), new User("Ivan", 17));
    
    users.stream()
        .map(u -> switch(u) {
            case User(var n, var a) when a >= 18 -> n + " (adult)";
            case User(var n, _) -> n + " (child)";
        })
        .forEach(System.out::println);
    
    System.out.println("Avg age: " + 
        users.stream().mapToInt(User::age).average().orElse(0));
}

record User(String name, int age) {}
