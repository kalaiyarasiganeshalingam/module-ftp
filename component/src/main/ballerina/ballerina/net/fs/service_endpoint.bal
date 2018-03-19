package ballerina.net.fs;

///////////////////////////////////////////
/// FileSystem ServiceEndpoint Endpoint ///
///////////////////////////////////////////
public struct ServiceEndpoint {
    Connection conn;
    ServiceEndpointConfiguration config;
}

@Description {value:"Configuration for local file system service endpoint"}
@Field {value:"host: Host of the service"}
@Field {value: "events: File system events to watch. eg:- create, delete, modify"}
@Field {value: "recursive: Recursively monitor all folders in the given folder path"}
public struct ServiceEndpointConfiguration {
    string dirURI;
    string events;
    boolean recursive;
}

@Description {value:"Gets called when the endpoint is being initialized during the package initialization."}
@Param {value:"config: The ServiceEndpointConfiguration of the endpoint"}
@Return {value:"Error occured during initialization"}
public function <ServiceEndpoint ep> init (ServiceEndpointConfiguration config) {
    ep.config = config;
    var err = ep.initEndpoint();
    if (err != null) {
        throw err;
    }
}

public native function <ServiceEndpoint ep> initEndpoint () returns (error);

@Description {value:"Gets called every time a service attaches itself to this endpoint. Also happens at package initialization."}
@Param {value:"ep: The endpoint to which the service should be registered to"}
@Param {value:"serviceType: The type of the service to be registered"}
public native function <ServiceEndpoint ep> register (type serviceType);

@Description {value:"Starts the registered service"}
public native function <ServiceEndpoint ep> start ();

@Description {value:"Returns the connector that client code uses"}
@Return {value:"The connector that client code uses"}
public native function <ServiceEndpoint ep> getClient () returns (Connection);

@Description {value:"Stops the registered service"}
public native function <ServiceEndpoint ep> stop ();

public struct Connection {}
