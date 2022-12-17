/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


%MappedType QMap<double, QString>
{
%TypeHeaderCode
// Include the library interface to the type being mapped.
#include <QMap>
#include <QString>
%End

%ConvertFromTypeCode
    PyObject *d = PyDict_New();

    if (!d)
        return 0;

    QMap<double, QString>::const_iterator it = sipCpp->constBegin();
    QMap<double, QString>::const_iterator end = sipCpp->constEnd();

    while (it != end)
    {
        PyObject *kobj = PyFloat_FromDouble(it.key());

        if (!kobj)
        {
            Py_DECREF(d);
            return 0;
        }

        QString *v = new QString(it.value());
        PyObject *vobj = sipConvertFromNewType(v, sipType_QString,
                sipTransferObj);

        if (!vobj)
        {
            delete v;
            Py_DECREF(kobj);
            Py_DECREF(d);
            return 0;
        }

        int rc = PyDict_SetItem(d, kobj, vobj);

        Py_DECREF(vobj);
        Py_DECREF(kobj);

        if (rc < 0)
        {
            Py_DECREF(d);
            return 0;
        }

        ++it;
    }

    return d;
%End

%ConvertToTypeCode
    if (!sipIsErr)
        return PyDict_Check(sipPy);

    QMap<double, QString> *qm = new QMap<double, QString>;

    Py_ssize_t pos = 0;
    PyObject *kobj, *vobj;

    while (PyDict_Next(sipPy, &pos, &kobj, &vobj))
    {
        PyErr_Clear();
        double k = PyFloat_AsDouble(kobj);

        if (PyErr_Occurred())
        {
            PyErr_Format(PyExc_TypeError,
                         "a key has type '%s' but 'float' is expected",
                         Py_TYPE(kobj)->tp_name);

            delete qm;
            *sipIsErr = 1;

            return 0;
        }

        int vstate;
        QString* v = reinterpret_cast<QString*>(
            sipForceConvertToType(
                vobj, sipType_QString, sipTransferObj, SIP_NOT_NONE, &vstate, sipIsErr
            )
        );

        if (*sipIsErr)
        {
            PyErr_Format(PyExc_TypeError,
                         "a value has type '%s' but 'QString' is expected",
                         Py_TYPE(vobj)->tp_name);
            sipReleaseType(v, sipType_QString, vstate);
            delete qm;
            return 0;
        }

        qm->insert(k, *v);

        sipReleaseType(v, sipType_QString, vstate);
    }

    *sipCppPtr = qm;

    return sipGetState(sipTransferObj);
%End
};


class QCPAxisTickerText : public QCPAxisTicker
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPAxisTickerText();
  
  // getters:
  QMap<double, QString> &ticks();
  int subTickCount() const;
  
  // setters:
  void setTicks(const QMap<double, QString> &ticks);
  void setTicks(const QVector<double> &positions, const QVector<QString> labels);
  void setSubTickCount(int subTicks);
  
  // non-virtual methods:
  void clear();
  void addTick(double position, QString label);
  void addTicks(const QMap<double, QString> &ticks);
  void addTicks(const QVector<double> &positions, const QVector<QString> &labels);

protected:
  // reimplemented virtual methods:
  virtual double getTickStep(const QCPRange &range);
  virtual int getSubTickCount(double tickStep);
  virtual QString getTickLabel(double tick, const QLocale &locale, QChar formatChar, int precision);
  virtual QVector<double> createTickVector(double tickStep, const QCPRange &range);
};
