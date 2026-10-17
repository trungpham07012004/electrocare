import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
const root=path.dirname(fileURLToPath(import.meta.url));
const dist=path.join(root,'dist');
fs.rmSync(dist,{recursive:true,force:true}); fs.mkdirSync(dist,{recursive:true});
for (const f of ['trang-chu.html','ung-dung.js','giao-dien.css']) fs.copyFileSync(path.join(root,f),path.join(dist,f));
console.log('Frontend build complete: dist/');
