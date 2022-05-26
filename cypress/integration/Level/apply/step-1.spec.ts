/// <reference types="cypress" />

const takeSnapShot = (width: number, label: string = '') => {
  const HEIGHT = 2000;
  cy.visit("https://www.google.com");
  cy.viewport(width, HEIGHT);
  cy.matchImageSnapshot(`${label}-${HEIGHT}x${width}`, {
    capture: 'viewport',
    customDiffConfig: { threshold: 0.001 }, // threshold for each pixel
    failureThreshold: 0.001, // threshold for entire image
    failureThresholdType: 'percent', // percent of image or number of pixels
    scale: true,
  });
};

describe.only('Level Apply', () => {
  it('Layout 2000 x 760 ', () => {
    console.log('Hello World POC');
  });  
  it('Layout 2000 x 769', () => {
    cy.get('button[type=submit]').contains('Next Step')
  });
  const takeSnapShotWithLabel = (width: number) => {
    takeSnapShot(width);
  };
  it.only(`should have a Layout 2000 x 760 `, () => {
    takeSnapShotWithLabel(760);
  });
});