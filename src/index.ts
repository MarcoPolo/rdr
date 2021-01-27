import minimist from 'minimist'
import { promises as fs } from 'fs'
import JSDOM from 'jsdom'
import { Readability } from '@mozilla/readability';

(async () => {

  const input = await fs.readFile('/dev/stdin', 'utf-8');
  var doc = new JSDOM.JSDOM(input, {
    url: "https://www.example.com/"
  })
  const reader = new Readability(doc.window.document);
  console.log(reader.parse()?.content);
})()
