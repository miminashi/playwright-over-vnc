import { chromium } from "playwright-core"

const browserServer = await chromium.launchServer({
  headless: false,
})

const wsEndpoint = browserServer.wsEndpoint()

const browser = await chromium.connect(wsEndpoint)

const context = await browser.newContext({
  baseURL: "https://blog.sh1ma.dev",
})

const page = await context.newPage()

await page.goto("/")
console.log(await page.title())

// clean up
await browser.close()
await context.close()
await browserServer.close()
