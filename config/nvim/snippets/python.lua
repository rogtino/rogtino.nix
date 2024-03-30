local function fn(
	args, -- text from i(2) in this example i.e. { { "456" } }
	parent, -- parent snippet or parent node
	user_args -- user_args from opts.user_args
)
	return "[" .. args[1][1] .. user_args .. "]"
end

return {
	s("fim", fmt("from {} import {}", ins_generate())),
	s("im", fmt("import {}", ins_generate())),
	s(
		"main",
		fmt(
			[[
            if __name__ == "__main__":
                {}

        ]],
			ins_generate()
		)
	),
	s(
		"onmessage",
		fmt(
			[[
def on_message(message, data):
    if message['type'] == 'send':
        print(f"[*] {{message['payload']}}")
        {}
    else:
        print(message)
{}

]],
			ins_generate()
		)
	),
	s(
		"frida",
		fmt(
			[[
        import frida


        def on_message(message, data):
        if message['type'] == 'send':
            print(f"[*] {{message['payload']}}")
        else:
            print(message)


            device = frida.get_usb_device()
            process = device.attach('com.{}')

            with open("{}.js") as f:
            jscode = f.read()

            script = process.create_script(jscode)
            script.on("message", on_message)
            script.load()


            for i in range(20, 30):
                for j in range(0, 10):
                    script.exports.{}({})
                    ]],
			ins_generate()
		)
	),
}
