HTMLFiles=$(ls Source/HTML)
if [ -f Source/HTML.ts ]; then
    rm Source/HTML.ts
fi
echo "// DO NOT MODIFY THIS FILE OR YOUR CHANGES WILL BE LOST!" >> Source/HTML.ts
echo "// This file is generated by GenerateHTML.sh" >> Source/HTML.ts
echo "// Last generated on $(date)" >> Source/HTML.ts
echo "" >> Source/HTML.ts

Counter=0
for file in $HTMLFiles
do
    echo "import File$Counter from './HTML/$file';" >> Source/HTML.ts
    Counter=$((Counter+1))
done
echo "" >> Source/HTML.ts

echo "const StaticFiles = {" >> Source/HTML.ts
Counter=0
for file in $HTMLFiles
do
    echo "    '$file': File$Counter," >> Source/HTML.ts
    Counter=$((Counter+1))
done
echo "};" >> Source/HTML.ts
echo "" >> Source/HTML.ts

echo "export class HTML {" >> Source/HTML.ts
echo "    private Path: string;" >> Source/HTML.ts
echo "    constructor(Path: string) {" >> Source/HTML.ts
echo "        this.Path = Path;" >> Source/HTML.ts
echo "    }" >> Source/HTML.ts
echo "" >> Source/HTML.ts
echo "    public Process(): object {" >> Source/HTML.ts
echo "        let ResponseData = {" >> Source/HTML.ts
echo "            Data: ''," >> Source/HTML.ts
echo "            ContentType: 'text/plain'," >> Source/HTML.ts
echo "        };" >> Source/HTML.ts
echo "        if (this.Path in StaticFiles) {" >> Source/HTML.ts
echo "            ResponseData.Data = StaticFiles[this.Path];" >> Source/HTML.ts
echo "            if (this.Path.endsWith('.html')) {" >> Source/HTML.ts
echo "                ResponseData.ContentType = 'text/html';" >> Source/HTML.ts
echo "            } else if (this.Path.endsWith('.js')) {" >> Source/HTML.ts
echo "                ResponseData.ContentType = 'text/javascript';" >> Source/HTML.ts
echo "            } else if (this.Path.endsWith('.css')) {" >> Source/HTML.ts
echo "                ResponseData.ContentType = 'text/css';" >> Source/HTML.ts
echo "            }" >> Source/HTML.ts
echo "        }" >> Source/HTML.ts
echo "        else {" >> Source/HTML.ts
echo "            ResponseData.Data = '404 Not Found';" >> Source/HTML.ts
echo "        }" >> Source/HTML.ts
echo "        return ResponseData;" >> Source/HTML.ts
echo "    }" >> Source/HTML.ts
echo "}" >> Source/HTML.ts