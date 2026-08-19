-- Archivos de definición del globales del sUNC para el luau language server
export type AnyFunction = (...any) -> (...any)
export type AnyTable = { [any]: any }
export type userdata = typeof(newproxy())

type Game = DataModel & {
    [any]: any
}

declare game: Game
declare Game: Game

declare function require(script: ModuleScript): any


---ENVIRONMENT
type GCFilterOptions = {
    Name: string?,
    IgnoreExecutor: boolean?,
    Hash: string?,
    Constants: {any}?,
    Upvalues: {any}?,
    Keys: { any }?,
    Values: {any}?,
    KeyValuePairs: AnyTable?,
    Metatable: {}?
}
do
    declare function getgc(includeTables: boolean): { AnyTable } | { AnyFunction } | AnyFunction | userdata
    declare function getgenv(): AnyTable
    declare function getreg(): AnyTable
    declare function getrenv(): AnyTable
    declare function setfpscap(fps: number): ()

    declare filtergc: 
    (( filterType: "function", filterOptions: GCFilterOptions, returnOne: true) -> AnyFunction? ) &
    ((( filterType: "function", filterOptions: GCFilterOptions, returnOne: false?) -> ( AnyFunction | { AnyFunction } ) )) &
    (( filterType: "table", filterOptions: GCFilterOptions, returnOne: true) -> { AnyTable? } ) &
    (( filterType: "table", filterOptions: GCFilterOptions, returnOne: false? ) -> { AnyTable })
end

--- METATABLE
do
    ---getnamecallmethod returns the name of the method that invoked the __namecall metamethod.
    ---When used inside a hookmetamethod hook targeting __namecall, it will attempt to retrieve the method being called (e.g. InvokeServer).
    ---When used outside of said hook, this function will safely return nil.
    declare function getnamecallmethod(): string?
    declare function getrawmetatable(object: { any } | userdata): { [any]: any } | nil
    declare function isreadonly(table: { any }): boolean
    declare function setrawmetatable<T>(object: T & ({ any } | userdata), metatable: { any }): T
    declare function setreadonly(table: { any }, state: boolean): ()
end

---EXECUTORS
do
    declare function identifyexecutor(): (string, string)
    declare syn: {}
    declare Xeno: {}
end

---FILES
do
    declare function appendfile(path: string, contents: string): ()
    declare function delfile(path: string): ()
    declare function delfolder(path: string): ()
    declare function getcustomasset(path: string): string
    declare function isfile(path: string): boolean
    declare function isfolder(path: string): boolean
    declare function listfiles(path: string): { string }
    declare function loadfile<A...>(path: string): ((A...) -> any | nil, string?)
    declare function makefolder(path: string): ()
    declare function readfile(path: string): string
    declare function writefile(path: string, data: string): ()
end

---DEBUG
do
    type DebugInfo = {
        source: string,
        short_src: string,
        what: string,
        name: string,
        currentline: number,
        linedefined: number,
        namewhat: string,
        nups: number,
        func: (...any) -> (...any)
    }

    declare debug: {
        getinfo: ((number, string) -> DebugInfo) & (((...any) -> any, string) -> DebugInfo) & (((...any) -> any) -> DebugInfo), 
        info: (<R...>(thread, number, string) -> R...) & (<R...>(number, string) -> R...) & (<A..., R1..., R2...>((A...) -> R1..., string) -> R2...),
        traceback: ((string?, number?) -> string) & ((thread, string?, number?) -> string),
        profilebegin: (label: string) -> (),
        profileend: () -> (),
        getmemorycategory: () -> string,
        setmemorycategory: (tag: string) -> (),
        resetmemorycategory: () -> (),
        getconstant: (func: (...any) -> (...any) | number, index: number) -> number | string | boolean | nil,
        getconstants: (func: (...any) -> (...any) | number) -> { number | string | boolean | nil },
        getproto: (func: (...any) -> (...any) | number, index: number, activated: boolean?) -> (...any) -> (...any) | { (...any) -> (...any) },
        getprotos: (func: (...any) -> (...any) | number) -> { (...any) -> (...any) },
        getstack: (level: number, index: number?) -> any | { any },
        getupvalue: (func: (...any) -> (...any) | number, index: number) -> any,
        getupvalues: (func: (...any) -> (...any) | number) -> { any },
        setconstant: (func: (...any) -> (...any) | number, index: number, value: number | string | boolean | nil) -> (),
        setstack: (level: number, index: number, value: any) -> (),
        setupvalue: (func: (...any) -> (...any) | number, index: number, value: any) -> ()
    }
end

--- CLOSURES
do
    declare function checkcaller(): boolean
    declare function clonefunction<A..., R...>(functionToClone: (A...) -> R...): (A...) -> R...
    declare function getfunctionhash(functionToHash: (...any) -> (...any)): string
    declare function hookfunction<A1..., R1..., A2..., R2...>(functionToHook: (A1...) -> R1..., hook: (A2...) -> R2...): (A1...) -> R1...
    declare function hookmetamethod(object: { [any]: any } | Instance | userdata, metamethodName: string, hook: (...any) -> (...any)): (...any) -> (...any)
    declare function iscclosure(func: (...any) -> (...any)): boolean
    declare function isexecutorclosure(func: (...any) -> (...any)): boolean
    declare function islclosure(func: (...any) -> (...any)): boolean
    declare function newcclosure<A..., R...>(functionToWrap: (A...) -> R...): (A...) -> R...
    declare function restorefunction(functionToRestore: (...any) -> (...any)): ()
end

--- INSTANCES
do
    declare function cloneref<T>(object: T & Instance): T
    declare function compareinstances(object1: Instance, object2: Instance): boolean
    declare function fireclickdetector(detector: ClickDetector, distance: number?, event: string?): ()
    declare function fireproximityprompt(prompt: ProximityPrompt): ()
    declare function firetouchinterest(part1: BasePart, part2: BasePart, toggle: boolean | number): ()
    declare function getcallbackvalue(object: Instance, property: string): any | nil
    declare function gethui(): BasePlayerGui | Folder
    declare function getinstances(): { Instance }
    declare function getnilinstances(): { Instance }
end

--- SCRIPTS
do
    declare function getcallingscript(): BaseScript | ModuleScript | nil
    declare function getloadedmodules(): { ModuleScript }
    declare function getrunningscripts(): { BaseScript | ModuleScript }
    declare function getscriptbytecode(script: BaseScript | ModuleScript): string | nil
    declare function getscriptclosure(script: BaseScript | ModuleScript): ((...any) -> (...any)) | nil
    declare function getscripthash(script: BaseScript | ModuleScript): string | nil
    declare function getscripts(): { BaseScript | ModuleScript }
    declare function getsenv(script: BaseScript | ModuleScript): { [any]: any } | nil
end

---WEB

export type RequestOptions = {
    Url: string,
    Method: "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "OPTIONS" | "PATCH",
    Body: string?,
    Headers: { [string]: string }?,
    Cookies: { [string]: string }?
}

export type RequestResponse = {
    Success: boolean,
    Body: string?,
    StatusCode: number,
    StatusMessage: string,
    Headers: { [string]: string }?
}

export type WebSocket = {
        OnMessage : RBXScriptSignal?,
        OnClose: RBXScriptSignal?,
        Send: (message: string) -> (),
        Close: () -> ()
    }
do
    declare function HttpGet(url: string): string
    declare function HttpPost(url: string, body: string, appcontent: string): string
    declare http : {
        request: (options: RequestOptions) -> RequestResponse
    }

    declare request: (options: RequestOptions) -> RequestResponse
    declare http_request: (options: RequestOptions) -> RequestResponse

    declare WebSocket: {
        connect: (url: string) -> WebSocket
    }
end
