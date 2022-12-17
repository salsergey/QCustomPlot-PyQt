/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


template <DataType>
class QCPDataContainer
{
%TypeHeaderCode
  #include <QtGlobal>
  #include <qcustomplot.h>
  #include "datacontainer.h"
  #include "datacontainer_helper.h"
%End
public:
  QCPDataContainer();
  
  // getters:
  int size() const;
  bool isEmpty() const;
  bool autoSqueeze() const;
  
  // setters:
  void setAutoSqueeze(bool enabled);
  
  // non-virtual methods:
  void set(const QCPDataContainer<DataType> &data);
  void set(const QVector<DataType> &data, bool alreadySorted=false);
  void add(const QCPDataContainer<DataType> &data);
  void add(const QVector<DataType> &data, bool alreadySorted=false);
  void add(const DataType &data);
  void removeBefore(double sortKey);
  void removeAfter(double sortKey);
  void remove(double sortKeyFrom, double sortKeyTo);
  void remove(double sortKey);
  void clear();
  void sort();
  void squeeze(bool preAllocation=true, bool postAllocation=true);

  QCPDataContainerIterator<DataType> *__iter__()  /Factory/;
%MethodCode
    // Here we don't need the template, SIP is automatically expanding the definition
    sipRes = new QCPDataContainerIterator(sipCpp);
%End


  QCPDataContainerIterator<DataType> *findBegin(double sortKey, bool expandedRange=true)  /Factory/;
%Docstring(format="deindented", signature="appended")
    Returns the data point with a (sort-)key that is equal to, just below, or just above sortKey.
    If expandedRange is true, the data point just below sortKey will be considered, otherwise the one just above.

    If expandedRange is true but there are no data points below sortKey, the first item is returned.

    If the container is empty, returns None.

    Iterator on the container is positioned on the returned item.
%End
%MethodCode
    // Here we don't need the template, SIP is automatically expanding the definition
    sipRes = new QCPDataContainerIterator(sipCpp, sipCpp->findBegin(a0, a1));
%End

  // This is not how the Python iterators work
  // const_iterator findEnd(double sortKey, bool expandedRange=true) const;

  QCPDataContainerIterator<DataType> *at(int index)  /Factory/;
%Docstring(format="deindented", signature="appended")
    Returns an iterator to the element with the specified index.
    If index points beyond the available elements in this container, returns None.
%End
%MethodCode
    QCPDataContainer::const_iterator itr = sipCpp->at(a0);
    sipRes = (itr == sipCpp->constEnd()) ? NULL : new QCPDataContainerIterator(sipCpp, itr);
%End

  QCPRange keyRange(bool &foundRange, QCP::SignDomain signDomain=QCP::sdBoth);
  QCPRange valueRange(bool &foundRange, QCP::SignDomain signDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange());
  QCPDataRange dataRange() const;

  // Again, we don't have end() iterators in Python
  // void limitIteratorsToDataRange(const_iterator &begin, const_iterator &end, const QCPDataRange &dataRange) const;

protected:
  // non-virtual methods:
  void preallocateGrow(int minimumPreallocSize);
  void performAutoSqueeze();
};


template<DataType>
class QCPDataContainerIterator
{
%TypeHeaderCode
  #include <qcustomplot.h>
  #include "datacontainer.h"
  #include "datacontainer_helper.h"
%End
public:
  QCPDataContainerIterator(QCPDataContainer<DataType> *container);

  const DataType *get();
%Docstring(format="deindented", signature="appended")
    Returns iterator current data point or None if iterator is invalid
%End

  // The iterator is iterable, so that we can call i.e. findBegin() on the
  // container and iterate over the result
  QCPDataContainerIterator<DataType> *__iter__();
%MethodCode
    sipRes = sipCpp;
%End

  const DataType *__next__();
%MethodCode
    sipRes = sipCpp->next();
    if (!sipRes) {
        PyErr_SetNone(PyExc_StopIteration);
        sipIsErr = 1;
    }
%End

  /* We discard consts here for simplicity. */
  bool __eq__(QCPDataContainerIterator *other);
%MethodCode
    sipRes = sipCpp->iterator() == a0->iterator();
%End

  bool __ne__(QCPDataContainerIterator *other);
%MethodCode
  sipRes = sipCpp->iterator() != a0->iterator();
%End

};
