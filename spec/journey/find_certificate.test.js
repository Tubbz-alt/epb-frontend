const {openBrowser, goto, write, into, click, closeBrowser, textBox, text, intercept} = require('taiko');
const {spawn} = require('child_process');

describe('Journey::Certificate', () => {
  let rackup_pid;
  let rackup_stdout = '';
  let rackup_resolved = false;
  let rackup_rejected = false;

  beforeAll(async () => {
    rackup_pid = await new Promise((resolve, reject) => {
      let rackup = spawn('make', ['run', 'ARGS=config_test.ru -p 9393']);

      rackup.stderr.on('data', line => {
        rackup_stdout += line.toString();

        if (line.indexOf('port=9393') !== -1 && !rackup_rejected && !rackup_resolved) {
          rackup_resolved = true;
          resolve(rackup.pid);
        }

        if (line.indexOf('*** [run] Error') !== -1 && !rackup_rejected && !rackup_resolved) {
          rackup_rejected = true;
          reject(rackup_stdout);
        }
      });
    });

    await openBrowser({
      args: [
        '--disable-gpu',
        '--disable-dev-shm-usage',
        '--disable-setuid-sandbox',
        '--no-first-run',
        '--no-sandbox',
        '--no-zygote']
    });
  });

  it('finds a certificate by postcode', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await write('SW1A 2AA', into(textBox('postcode')));
    await click('Find');
  }, 30000);

  it('finds a certificate by postcode in Welsh', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click('Welsh (Cymraeg)');
    await click('Welsh: Start now');
    await write('SW1A 2AA', into(textBox('postcode')));
    await click('Welsh: Find');
  }, 30000);

  it('displays an error message when entering an empty postcode', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await write('', into(textBox('postcode')));
    await click('Find');
    let result = await text('Enter a real postcode').exists();

    expect(result).toBeTruthy();
  }, 30000);

  it('displays an error message when entering an invalid postcode', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await write('NOT A POSTCODE', into(textBox('postcode')));
    await click('Find');
    let result = await text('Enter a real postcode').exists();

    expect(result).toBeTruthy();
  }, 30000);


  it('displays the find a certificate page heading when entering a valid postcode ', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await write('SW1A 2AA', into(textBox('postcode')));
    await click('Find');
    let result = await text('of 3 results matching').exists();

    expect(result).toBeTruthy();
  }, 30000);


  it('displays an error message when entering an empty reference number', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('certificate by reference');
    await write('', into(textBox({id: 'reference_number'})));
    await click('Find');
    let result = await text('Enter a valid reference number').exists();

    expect(result).toBeTruthy();
  }, 30000);

  it('displays the find a certificate page heading when entering a valid certificate reference number', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('certificate by reference');
    await write('1234-5678-9101-1121', into(textBox({id: 'reference_number'})));
    await click('Find');
    let result = await text('of 1 results matching').exists();

    expect(result).toBeTruthy();
  }, 30000);


  it('displays an error message when entering an empty street name', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('Find certificate by street name');
    await write('Beauty Town', into(textBox({id: 'town'})));
    await click('Find');
    let result = await text('Enter a street name').exists();

    expect(result).toBeTruthy();
  }, 30000);

  it('displays an error message when entering an empty town', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('Find certificate by street name');
    await write('1 Makeup Street', into(textBox({id: 'street_name'})));
    await click('Find');
    let result = await text('Enter a town').exists();

    expect(result).toBeTruthy();
  }, 30000);

  it('displays an error message when entering an empty town and street name', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('Find certificate by street name');
    await click('Find');
    let town_result = await text('Enter a town').exists();
    expect(town_result).toBeTruthy();
    let street_name_result = await text('Enter a street name').exists();

    expect(street_name_result).toBeTruthy();
  }, 30000);

  it('displays the find a certificate page heading when entering a valid query', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('Find certificate by street name');
    await write('1 Makeup Street', into(textBox({id: 'street_name'})));
    await write('Beauty Town', into(textBox({id: 'town'})));
    await click('Find');
    let result = await text('of 3 results matching').exists();

    expect(result).toBeTruthy();
  }, 30000);

  it('displays the error message when searching for a certificate that doesnt exist', async () => {
    await goto("localhost:9393/find-a-certificate");
    await click("Start now");
    await click('Find certificate by street name');
    await write('Madeup Street', into(textBox({id: 'street_name'})));
    await write('Madeup Town', into(textBox({id: 'town'})));
    await click('Find');
    await text('A certificate was not found at this address.').exists();
    await click('Find an assessor');

    let result = await text('Getting a new Energy Performance Certificate (EPC)').exists();

    expect(result).toBeTruthy();
  }, 30000);

  afterAll(async () => {
    await closeBrowser();
    process.kill(rackup_pid, "SIGTERM")
  });
});
