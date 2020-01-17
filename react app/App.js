import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import StudentForm from './StudentForm';
import 'semantic-ui-css/semantic.min.css';

class App extends Component {
  render() {
    return (
      <div>
        <h1>Student Submission Form</h1>
        <StudentForm />
      </div>
    );
  }
}

export default App;
