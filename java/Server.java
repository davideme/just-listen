import com.sun.net.httpserver.HttpServer;
import java.net.InetSocketAddress;

class Server {
    public static void main(String[] args) throws Exception {
        var server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/", e -> { e.sendResponseHeaders(200, -1); e.close(); });
        server.setExecutor(null);
        server.start();
    }
}
