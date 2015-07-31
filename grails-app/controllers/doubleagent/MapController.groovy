package doubleagent

class MapController {

    FileLoader loader;
    MapController(){
        loader = new FileLoader();
    }
    def index() {
        def agents = loader.GetDoubleAgents()

        [agents:agents]
    }
}
