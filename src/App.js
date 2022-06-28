import logo from './level-logo.png';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Welcome to Level react test app!
        </p>
        <a
          className="App-link"
          href="https://levelgoals.com"
          target="_blank"
          rel="noopener noreferrer"
        >
          Level
        </a>
      </header>
    </div>
  );
}

export default App;
