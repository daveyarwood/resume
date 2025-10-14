import { promises as fs } from "fs";
import puppeteer from "puppeteer";

const htmlFilename = "resume.html";
const pdfFilename = "resume.pdf";

const html = await fs.readFile(htmlFilename, "utf-8");

console.log(`Generating ${pdfFilename}...`);

const browser = await puppeteer.launch({ headless: "new", args: ['--no-sandbox', '--disable-setuid-sandbox'] });
const page = await browser.newPage();

await page.setContent(html, { waitUntil: "networkidle0" });
await page.pdf({ path: pdfFilename, format: "a4", printBackground: true });
await browser.close();
